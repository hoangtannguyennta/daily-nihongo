class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    total = Vocabulary.count

    user_vocab = current_user.user_vocabularies

    @known = user_vocab.where(status: :remembered).count
    @unknown = user_vocab.where(status: :not_remembered).count
    @not_learned = total - (@known + @unknown)

    @total = total
    @progress = total > 0 ? (@known.to_f / total * 100).round : 0

    # Tổng điểm từ tất cả các lần làm bài tập
    @total_score = current_user.test_attempts.sum(:score)

    # Tính tiến độ theo số bài tập đã hoàn thành (đạt điểm tối đa)
    all_lessons = Lesson.all
    total_lessons = all_lessons.count
    @successful_lessons_count = current_user.test_attempts.where("score = total_questions").distinct.count(:lesson_id)
    @quiz_progress = total_lessons > 0 ? (@successful_lessons_count.to_f / total_lessons * 100).round : 0

    # Chọn bài học ngẫu nhiên cho thử thách hằng ngày (giữ nguyên trong 1 ngày)
    @daily_lesson = all_lessons.sample(random: Random.new(Date.today.to_time.to_i))

    # Tính chuỗi ngày học liên tiếp (Streak)
    @streak_count = calculate_streak
  end

  private


  def calculate_streak
    # Lấy danh sách các ngày duy nhất mà user đã làm bài test, sắp xếp giảm dần
    activity_dates = current_user.test_attempts.pluck(:created_at)
                                 .map(&:to_date).uniq.sort.reverse
    return 0 if activity_dates.empty?

    streak = 0
    current_date = Date.today

    # Nếu hôm nay không làm bài, kiểm tra xem hôm qua có làm không để giữ streak
    if activity_dates.first != current_date && activity_dates.first != current_date - 1
      return 0
    end

    # Bắt đầu đếm từ ngày có hoạt động gần nhất
    check_date = activity_dates.first
    activity_dates.each do |date|
      if date == check_date
        streak += 1
        check_date -= 1
      else
        break
      end
    end
    streak
  end
end
