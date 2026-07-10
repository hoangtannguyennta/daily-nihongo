class SessionsController < ApplicationController
  def new
    # form login
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect_to root_path, notice: "Login thành công"

      # UserMailer.otp_email(user.email, session[:otp_code]).deliver_now # Gửi lại mã nếu chưa verify
      # redirect_to new_otp_verification_path, alert: "Tài khoản chưa được kích hoạt. Vui lòng kiểm tra email."

      # if user.otp_verified?
      #   session[:user_id] = user.id
      #   redirect_to root_path, notice: "Login thành công"
      # else
      # end

    else
      flash.now[:alert] = "Sai email hoặc password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Đã logout"
  end
end
