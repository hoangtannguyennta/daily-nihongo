class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :user_vocabularies
  has_many :vocabularies, through: :user_vocabularies
  has_many :test_attempts

  before_create :generate_otp

  def activate!
    update(otp_verified: true, otp_code: nil)
  end

  def resend_otp!
    generate_otp
    save!
  end

  private

  def generate_otp
    self.otp_code = rand(100000..999999).to_s
    self.otp_verified = false
  end
end
