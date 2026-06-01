class KanasController < ApplicationController
  before_action :set_kana, only: %i[ show edit update destroy ]

  def index
    @hiragana = Kana.where(kind: "hiragana")
    @katakana = Kana.where(kind: "katakana")
  end

  def show
  end

  def new
    @kana = Kana.new
  end

  def edit
  end

  def create
    @kana = Kana.new(kana_params)

    respond_to do |format|
      if @kana.save
        format.html { redirect_to kanas_path, notice: "Kana was successfully created." }
        format.json { render :show, status: :created, location: @kana }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kana.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kana.update(kana_params)
        format.html { redirect_to kanas_path, notice: "Kana was successfully updated." }
        format.json { render :show, status: :ok, location: @kana }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kana.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kana.destroy!

    respond_to do |format|
      format.html { redirect_to kanas_path, notice: "Kana was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def quiz
    respond_to do |format|
      format.json do
        kanas_scope = Kana.all
        kanas_scope = kanas_scope.where(kind: params[:kind]) if params[:kind].present? && %w[hiragana katakana].include?(params[:kind])

        # Lấy một chữ cái ngẫu nhiên làm câu hỏi
        correct = kanas_scope.order("RANDOM()").first
        return render json: { question: "Hết dữ liệu", options: [], correct: "" } unless correct

        # Lấy 3 đáp án sai ngẫu nhiên
        wrong = kanas_scope.where.not(id: correct.id).order("RANDOM()").limit(3)

        # Nếu không đủ đáp án sai trong cùng loại, lấy thêm từ loại khác để đảm bảo đủ 4 lựa chọn
        if wrong.count < 3
          extra = Kana.where.not(id: [ correct.id ] + wrong.pluck(:id)).order("RANDOM()").limit(3 - wrong.count)
          wrong = wrong.to_a + extra.to_a
        end

        options = (wrong.to_a + [ correct ]).shuffle

        render json: {
          question: correct.character,
          correct: correct.romaji,
          options: options.map(&:romaji)
        }
      end
    end
  end

  private

  def set_kana
    @kana = Kana.find(params.expect(:id))
  end

  def kana_params
    # Cho phép nhận các tham số character, romaji, kind và quan trọng là image
    params.expect(kana: [ :character, :romaji, :kind, :image ])
  end
end
