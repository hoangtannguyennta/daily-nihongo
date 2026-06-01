class Vocabulary < ApplicationRecord
  belongs_to :lesson
  has_many_attached :images
  has_one_attached :audio
  has_many :user_vocabularies
  has_many :users, through: :user_vocabularies
  has_many :test_answers

  # Khai báo enum cho priority
  enum :priority, { low: 0, normal: 1, high: 2 }, default: :normal

  # Validation tương tự Laravel: required, min, max, unique
  validates :word, presence: true,
                   length: { minimum: 2, maximum: 100 },
                   uniqueness: { case_sensitive: false }

  validates :meaning, presence: true,
                      length: { maximum: 255 }

  # Custom validation cho hình ảnh (giống mimes và size trong Laravel)
  validate :validate_images

  private

  def validate_images
    return unless images.attached?

    images.each do |image|
      # Kiểm tra định dạng file (đuôi file)
      unless image.content_type.in?(%w[image/jpeg image/png image/webp image/gif image/jpg])
        errors.add(:images, "phải có định dạng JPG, PNG, WEBP hoặc GIF")
      end

      # Kiểm tra dung lượng file (ví dụ max 5MB)
      if image.blob.byte_size > 5.megabytes
        errors.add(:images, "dung lượng ảnh không được quá 5MB")
      end
    end
  end
end
