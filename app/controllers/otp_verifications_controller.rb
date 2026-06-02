class OtpVerificationsController < ApplicationController
  def new
    @email = params[:email]
    user = User.find_by(email: @email)

    if user&.otp_verified?
      redirect_to root_path, notice: "Tài khoản của bạn đã được xác thực trước đó."
    end
  end

  def create
    @user = User.find_by(email: params[:email], otp_code: params[:otp_code])

    if @user
      @user.activate!
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Kích hoạt tài khoản thành công!"
    else
      flash.now[:alert] = "Mã xác thực không chính xác."
      @email = params[:email]
      render :new, status: :unprocessable_entity
    end
  end


  def resend
    @user = User.find_by(email: params[:email])

    if @user
      if @user.otp_verified?
        redirect_to root_path, notice: "Tài khoản của bạn đã được xác thực."
      else
        @user.resend_otp!
        UserMailer.welcome_email(@user).deliver_now
        redirect_to new_otp_verification_path(email: @user.email), notice: "Mã xác thực mới đã được gửi đến email của bạn."
      end
    else
      redirect_to login_path, alert: "Không tìm thấy thông tin tài khoản."
    end
  end
end
