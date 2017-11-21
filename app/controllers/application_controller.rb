class ApplicationController < ActionController::Base
  # It uses pundit for authorization methods
  include Pundit

  # Manages pundit errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Set Layout
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Only the application can access the methods
  protected

  # Layout per resource_name
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "backoffice_devise"
    elsif devise_controller? && resource_name == :member
      "site_devise"
    else
      "application"
    end
  end

  def user_not_authorized
      flash[:alert] = t('messages.not_authorized')
      redirect_to(request.referrer || root_path)
    end
end
