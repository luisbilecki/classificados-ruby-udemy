class Site::Profile::AdsController < Site::ProfileController
  def index
    @ads = Ad.ads_to_cm(current_member)
  end
end
