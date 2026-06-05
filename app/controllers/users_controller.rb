class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Gán vai trò mặc định là user
    @user.role = "user" if @user.respond_to?(:role=)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Chào mừng bạn đến với Daily Nihongo! Đăng ký thành công."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password, :password_confirmation ])
  end
end
