class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit, :update]

  def index
    @ads = Ad.ads_to_cm(current_member)
  end

  def edit
    # set ad via before action
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end
end
