class UserVocabulariesController < ApplicationController
  before_action :authenticate_user!

  # GET /user_vocabularies
  def index
    @user_vocabularies = current_user.user_vocabularies.includes(:vocabulary)

    if params[:status].present?
      @user_vocabularies = @user_vocabularies.where(status: params[:status])
    end

    @user_vocabularies = @user_vocabularies.joins(:vocabulary)
                                          .order("vocabularies.lesson_id ASC")
                                          .page(params[:page]).per(20)
  end

  # POST /user_vocabularies/update_status
  def update_status
    vocab = Vocabulary.find(params[:vocabulary_id])

    uv = UserVocabulary.find_or_create_by(
      user: current_user,
      vocabulary: vocab
    )

    # params[:status] = "remembered", "not_remembered" hoặc "not_learned"
    uv.update(status: params[:status])

    render json: {
      message: "Updated",
      status: uv.status
    }
  end

  # GET /user_vocabularies/progress
  def progress
    @total_count = Vocabulary.count
    @remembered_count = current_user.user_vocabularies.remembered.count
    @not_remembered_count = current_user.user_vocabularies.not_remembered.count
    @not_learned_count = @total_count - (@remembered_count + @not_remembered_count)

    @overall_progress = @total_count > 0 ? (@remembered_count.to_f / @total_count * 100).round(1) : 0

    # Thống kê chi tiết theo từng bài học
    @lesson_stats = Lesson.all.order(number: :asc).map do |lesson|
      total_in_lesson = lesson.vocabularies.count
      next if total_in_lesson == 0

      remembered_in_lesson = current_user.user_vocabularies.where(vocabulary_id: lesson.vocabularies.ids).remembered.count
      {
        id: lesson.id,
        name: lesson.name,
        total: total_in_lesson,
        remembered: remembered_in_lesson,
        percent: (remembered_in_lesson.to_f / total_in_lesson * 100).round(0)
      }
    end.compact

    respond_to do |format|
      format.html
      format.json { render json: { progress: @overall_progress } }
    end
  end

  # GET /user_vocabularies/total_score
  def total_score
    @test_attempts = current_user.test_attempts.includes(:lesson).order(created_at: :desc)
    @total_score = @test_attempts.sum(:score)
    @total_questions = @test_attempts.sum(:total_questions)
    @total_successful = current_user.test_attempts.where("score = total_questions").count
  end
end
