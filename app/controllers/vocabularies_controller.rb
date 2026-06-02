class VocabulariesController < ApplicationController
  before_action :set_vocabulary, only: %i[ show edit update destroy ]
  before_action :set_lessons, only: %i[ index new edit create update ]

  def index
    @vocabularies = Vocabulary.with_attached_images.order(lesson_id: :asc)

    @vocabularies = @vocabularies.where(lesson_id: params[:lesson_id]) if params[:lesson_id].present?

    if params[:query].present?
      query = "%#{params[:query]}%"
      @vocabularies = @vocabularies.where("word LIKE ? OR meaning LIKE ? OR romaji LIKE ?", query, query, query)
    end

    @vocabularies = @vocabularies.page(params[:page]).per(70)

    # Lấy trạng thái từ vựng của người dùng hiện tại để hiển thị trên danh sách
    @user_statuses = current_user ? current_user.user_vocabularies.pluck(:vocabulary_id, :status).to_h : {}
  end

  # GET /vocabularies/1 or /vocabularies/1.json
  def show
  end

  # GET /vocabularies/new
  def new
    @vocabulary = Vocabulary.new
    @vocabulary.priority = :normal
  end

  # GET /vocabularies/1/edit
  def edit
  end

  # POST /vocabularies or /vocabularies.json
  def create
    @vocabulary = Vocabulary.new(vocabulary_params)

    respond_to do |format|
      if @vocabulary.save
        format.html { redirect_to @vocabulary, notice: "Từ vựng đã được tạo thành công.", status: :see_other }
        format.json { render :show, status: :created, location: @vocabulary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vocabulary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vocabularies/1 or /vocabularies/1.json
  def update
    v_params = vocabulary_params

    # Handle existing image deletions
    if v_params[:attachments_to_purge].present?
      v_params[:attachments_to_purge].each do |signed_id|
        blob = ActiveStorage::Blob.find_signed(signed_id)
        @vocabulary.images.find_by(blob_id: blob.id)&.purge if blob
      end
    end

    # Handle audio deletion
    if params[:vocabulary][:purge_audio] == "1"
      @vocabulary.audio.purge
    end

    # CHỖ THAY ĐỔI: Chạy logic update trước, rồi mới respond_to dựa trên kết quả
    if @vocabulary.update(v_params.except(:images, :attachments_to_purge))
        # Handle new image attachments
        if v_params[:images].present?
          @vocabulary.images.attach(v_params[:images])
        end

      respond_to do |format|
        format.html {
          redirect_to @vocabulary,
          notice: "Từ vựng đã được cập nhật thành công.",
          status: :see_other
        }
        format.json {
          render :show,
          status: :ok,
          location: @vocabulary
        }
      end
    else
      respond_to do |format|
        format.html {
          render :edit,
          status: :unprocessable_entity
        }
        format.json {
          render json: @vocabulary.errors,
          status: :unprocessable_entity
        }
      end
    end
  end
  
  # DELETE /vocabularies/1 or /vocabularies/1.json
  def destroy
    @vocabulary.destroy!

    respond_to do |format|
      format.html { redirect_to vocabularies_url, notice: "Vocabulary was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # Existing actions below this line
  def random
    kana = Kana.order("RANDOM()").first
    render json: kana
  end

  def quiz
    @lesson = Lesson.find_by(id: params[:lesson_id])
    # 1. Base scope
    base_scope = @lesson ? @lesson.vocabularies : Vocabulary.all


    # 2. Apply filters
    quiz_scope = apply_filters(base_scope)

    respond_to do |format|
      format.html do
        # Lưu lại URL trang trước đó để nút "Quay lại" có thể về đúng vị trí cũ (kèm filter/search)
        # Chỉ lưu nếu trang trước không phải là chính nó (tránh vòng lặp)
        referer = request.referer
        if referer.present? && !referer.include?(quiz_vocabularies_path)
          session[:quiz_return_to] = referer
        end
        # Khi bắt đầu hoặc tải lại trang Quiz, reset danh sách từ đã hiển thị
        session[:quiz_shown_ids] = []
      end

      format.json do
        # Lấy danh sách ID đã hiển thị từ session
        shown_ids = session[:quiz_shown_ids] || []

        # Chọn từ tiếp theo không nằm trong danh sách đã hiển thị trong lượt này
        correct = quiz_scope.where.not(id: shown_ids).order("RANDOM()").first

        return render json: { question: "Hết từ vựng", options: [], correct: "" } unless correct

        # Lưu ID của từ hiện tại vào session để tránh lặp lại ở câu tiếp theo
        (session[:quiz_shown_ids] ||= []) << correct.id

        wrong = base_scope.where.not(id: correct.id)
                          .order("RANDOM()")
                          .limit(3)

        if wrong.count < 3
          extra = Vocabulary.where.not(id: [ correct.id ] + wrong.pluck(:id))
                            .order("RANDOM()")
                            .limit(3 - wrong.count)
          wrong = wrong.to_a + extra.to_a
        end

        options = (wrong.to_a + [ correct ]).shuffle

        render json: {
          question: correct.word,
          correct: correct.meaning,
          options: options.map(&:meaning),
          audio_url: correct.audio.attached? ? rails_blob_url(correct.audio) : nil
        }
      end
    end
  end

  # Action để xóa session quiz_shown_ids
  def clear_quiz_session
    session[:quiz_shown_ids] = []
    # Lấy URL đã lưu hoặc mặc định về trang danh sách nếu không có
    return_path = session.delete(:quiz_return_to) || vocabularies_path
    redirect_to return_path, status: :see_other
  end
  private

  def apply_filters(scope)
    result = scope

    if params[:filter] == "not_learned" && current_user
      # Lấy ID của các từ vựng đã có trạng thái (đã thuộc hoặc đang học)
      learned_ids = current_user.user_vocabularies.pluck(:vocabulary_id)
      # Lọc ra các từ vựng KHÔNG nằm trong danh sách đã học
      # 
      result = result.where.not(id: learned_ids)
    elsif params[:filter].present? && current_user && UserVocabulary.statuses.key?(params[:filter])
      target_ids = current_user.user_vocabularies
                              .where(status: params[:filter])
                              .pluck(:vocabulary_id)

      result = result.where(id: target_ids)
    end

    if params[:query].present?
      q = "%#{params[:query]}%"
      result = result.where(
        "vocabularies.word LIKE ? OR vocabularies.meaning LIKE ? OR vocabularies.romaji LIKE ?",
        q, q, q
      )
    end

    result
  end

  def set_vocabulary
    @vocabulary = Vocabulary.find(params.expect(:id))
  end

  def set_lessons
    @lessons = Lesson.all.order(number: :asc)
  end

  def vocabulary_params
    params.require(:vocabulary).permit(
      :word,
      :meaning,
      :lesson_id,
      :audio,
      :priority,
      :romaji,
      images: [],
      attachments_to_purge: []
    )
  end
end
