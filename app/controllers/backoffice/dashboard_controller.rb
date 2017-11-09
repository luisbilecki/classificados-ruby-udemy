class Backoffice::DashboardController < ApplicationController
  #Antes de qualquer ação pede a autenticação
  before_action :authenticate_admin!

  layout "backoffice"

  def index
  end
end
