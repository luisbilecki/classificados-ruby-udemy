class Backoffice::SendMailController < ApplicationController

  def edit
    #Variável de instância, pode usar na view
    @admin = Admin.find(params[:id])

    respond_to  do | format |
      format.js
    end
  end

  def create

  end

end
