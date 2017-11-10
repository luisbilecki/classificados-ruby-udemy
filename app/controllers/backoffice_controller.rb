  class BackofficeController < ApplicationController
    #Antes de qualquer ação pede a autenticação
    before_action :authenticate_admin!

    layout "backoffice"
  end
