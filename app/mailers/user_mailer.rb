class UserMailer < ActionMailer::Base
  default from: "Daily Nihongo <nguyenht.nta@gmail.com>"
  
  def welcome_email(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Mã xác nhận kích hoạt tài khoản - #{@user.otp_code}"
    )
  end
end
