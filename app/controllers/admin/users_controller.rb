class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: %i[ edit update destroy ]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "Người dùng đã được tạo thành công."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Loại bỏ password nếu admin không nhập mật khẩu mới khi sửa
    params_to_update = user_params.to_h
    if params_to_update[:password].blank?
      params_to_update.delete(:password)
      params_to_update.delete(:password_confirmation)
    end

    if @user.update(params_to_update)
      redirect_to admin_users_path, notice: "Thông tin người dùng đã được cập nhật."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "Người dùng đã được xóa."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
  end
end
