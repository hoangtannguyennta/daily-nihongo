class TestAttemptsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lessons = Lesson.all.order(number: :asc)
  end

  def start_test
    lesson = Lesson.find(params[:lesson_id])

    vocabularies = lesson.vocabularies.order("RANDOM()")

    questions = vocabularies.map do |vocab|
      wrong = Vocabulary.where.not(id: vocab.id).sample(3)

      {
        vocabulary_id: vocab.id,
        question: vocab.word,
        options: (wrong.map(&:meaning) + [ vocab.meaning ]).shuffle
      }
    end

    render json: questions
  end

  def submit_test
    attempt = TestAttempt.create!(
      user: current_user,
      lesson_id: params[:lesson_id],
      score: 0,
      total_questions: params[:answers].size
    )

    correct_count = 0

    params[:answers].each do |ans|
      vocab = Vocabulary.find(ans[:vocabulary_id])

      selected = ans[:selected_answer]
      correct_answer = vocab.meaning
      is_correct = (selected == correct_answer)

      correct_count += 1 if is_correct

      TestAnswer.create!(
        test_attempt: attempt,
        vocabulary: vocab,
        selected_answer: selected,
        correct_answer: correct_answer,
        correct: is_correct
      )
    end

    attempt.update(score: correct_count)

    render json: {
      score: correct_count,
      total: attempt.total_questions
    }
  end
end
