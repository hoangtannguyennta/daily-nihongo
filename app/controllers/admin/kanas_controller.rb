class Admin::KanasController < Admin::AdminController
  before_action :set_kana, only: %i[ edit update destroy ]

  def index
    @kanas = Kana.all.order(kind: :asc, romaji: :asc)
  end

  def new
    @kana = Kana.new
  end

  def edit
  end

  def create
    @kana = Kana.new(kana_params)
    if @kana.save
      redirect_to admin_kanas_path, notice: "Đã thêm chữ cái mới."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @kana.update(kana_params)
      redirect_to admin_kanas_path, notice: "Đã cập nhật chữ cái."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kana.destroy
    redirect_to admin_kanas_path, notice: "Đã xóa chữ cái."
  end

  private

  def set_kana
    @kana = Kana.find(params[:id])
  end

  def kana_params
    params.require(:kana).permit(:character, :romaji, :kind, :image)
  end
end
