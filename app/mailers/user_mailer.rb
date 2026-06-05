class UserMailer < ApplicationMailer
  default from: "no-reply@dailynihongo.com"

  def otp_email(email, otp)
    @otp = otp
    mail(to: email, subject: "Mã xác thực đăng ký tài khoản Daily Nihongo")
  end
end
