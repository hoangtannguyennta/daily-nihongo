class OtpVerificationsController < ApplicationController
  def new
    # Nếu không có thông tin đăng ký chờ sẵn, quay về trang signup
    redirect_to signup_path unless session[:pending_user]
  end

  def create
    if params[:otp] == session[:otp_code]
      @user = User.new(session[:pending_user])
      @user.role = "user"

      if @user.save
        # Xóa dữ liệu tạm và đăng nhập
        session[:user_id] = @user.id
        session.delete(:pending_user)
        session.delete(:otp_code)

        redirect_to root_path, notice: "Xác thực thành công! Chào mừng bạn."
      else
        redirect_to signup_path, alert: "Có lỗi xảy ra khi tạo tài khoản."
      end
    else
      flash.now[:alert] = "Mã OTP không chính xác. Vui lòng thử lại!"
      render :new, status: :unprocessable_entity
    end
  end
end
