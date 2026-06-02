class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to new_otp_verification_path(email: @user.email), notice: "Mã xác thực đã được gửi đến email của bạn."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Cập nhật người dùng thành công."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Xóa người dùng thành công."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    # Cho phép password có thể để trống khi update nếu không muốn đổi mật khẩu
    params.require(:user).permit(:email, :password, :password_confirmation).compact_blank
  end
end
