class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  layout "admin"

  private

  def ensure_admin!
    unless current_user&.role == "admin"
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Bạn không có quyền truy cập vùng quản trị!" }
        format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      end
    end
  end
end
