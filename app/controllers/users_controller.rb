class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      # Lưu thông tin tạm thời vào session thay vì database
      session[:pending_user] = user_params.to_h
      # Tạo mã OTP ngẫu nhiên (Giả lập gửi qua email)
      session[:otp_code] = (rand(100000..999999)).to_s

      redirect_to new_otp_verification_path, notice: "Mã xác thực OTP đã được gửi! (Mã của bạn là: #{session[:otp_code]})"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
