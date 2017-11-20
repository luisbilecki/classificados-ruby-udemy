class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit, :update]

  def index
    @ads = Ad.ads_to_cm(current_member)
  end

  def edit
    # set ad via before action
  end

  def update
    if @ad.update(params_ad)
      redirect_to site_profile_ads_path, notice: "Anúncio atualizado com sucesso!"
    else
      render :edit
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def params_ad
    params.require(:ad).permit(:id, :title, :category_id, :price, :description, :picture)
  end
end
