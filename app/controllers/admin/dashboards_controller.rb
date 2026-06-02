class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  layout "admin"

  def show
    @total_users = User.count
    @total_vocabularies = Vocabulary.count
    @new_users_this_week = User.where("created_at >= ?", 7.days.ago).count
    @recent_users = User.order(created_at: :desc).limit(5)
  end

  private

  def ensure_admin!
    # Kiểm tra quyền admin dựa trên trường role trong model User
    unless current_user&.role == "admin"
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Bạn không có quyền truy cập!" }
        format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      end
    end
  end
end
