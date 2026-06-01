class KanjisController < ApplicationController
  before_action :set_kanji, only: %i[ show edit update destroy ]

  # GET /kanjis or /kanjis.json
  def index
    @kanjis = Kanji.all.order(id: :asc)

    if params[:query].present?
      query = "%#{params[:query]}%"
      @kanjis = @kanjis.where("character LIKE ? OR meaning LIKE ? OR onyomi LIKE ? OR kunyomi LIKE ?", query, query, query, query)
    end

    @kanjis = @kanjis.page(params[:page]).per(70)
  end

  # GET /kanjis/1 or /kanjis/1.json
  def show
  end

  # GET /kanjis/new
  def new
    @kanji = Kanji.new
  end

  # GET /kanjis/1/edit
  def edit
  end

  # POST /kanjis or /kanjis.json
  def create
    @kanji = Kanji.new(kanji_params)

    respond_to do |format|
      if @kanji.save
        format.html { redirect_to kanjis_path, notice: "Kanji đã được tạo thành công." }
        format.json { render :show, status: :created, location: @kanji }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kanji.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kanjis/1 or /kanjis/1.json
  def update
    respond_to do |format|
      if @kanji.update(kanji_params)
        format.html { redirect_to kanjis_path, notice: "Kanji đã được cập nhật thành công.", status: :see_other }
        format.json { render :show, status: :ok, location: @kanji }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kanji.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kanjis/1 or /kanjis/1.json
  def destroy
    @kanji.destroy!

    respond_to do |format|
      format.html { redirect_to kanjis_url, notice: "Kanji đã được xóa thành công.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /kanjis/quiz
  def quiz
    respond_to do |format|
      format.html do
        # Lưu lại URL trang trước đó để có thể quay lại
        referer = request.referer
        if referer.present? && !referer.include?(quiz_kanjis_path)
          session[:kanji_quiz_return_to] = referer
        end
        # Reset danh sách ID đã hiển thị khi bắt đầu lượt quiz mới
        session[:kanji_shown_ids] = []
      end

      format.json do
        kanjis_scope = Kanji.all
        kanjis_scope = kanjis_scope.where(jlpt_level: params[:jlpt_level]) if params[:jlpt_level].present?

        shown_ids = session[:kanji_shown_ids] || []
        correct = kanjis_scope.where.not(id: shown_ids).order("RANDOM()").first

        return render json: { question: "Hết dữ liệu Kanji", options: [], correct: "" } unless correct

        (session[:kanji_shown_ids] ||= []) << correct.id

        wrong_meanings = kanjis_scope.where.not(id: correct.id)
                                     .order("RANDOM()")
                                     .limit(3)
                                     .pluck(:meaning)

        options = (wrong_meanings + [ correct.meaning ]).shuffle

        render json: {
          question: correct.character,
          correct: correct.meaning,
          options: options
        }
      end
    end
  end

  # Action để xóa session quiz cho Kanji
  def clear_quiz_session
    session[:kanji_shown_ids] = []
    return_path = session.delete(:kanji_quiz_return_to) || kanjis_path
    redirect_to return_path, status: :see_other
  end

  private

  def set_kanji
    @kanji = Kanji.find(params.expect(:id))
  end

  def kanji_params
    params.require(:kanji).permit(:character, :onyomi, :kunyomi, :meaning, :stroke_count, :jlpt_level)
  end
end
