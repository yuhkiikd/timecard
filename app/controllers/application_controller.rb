class ApplicationController < ActionController::Base
  include TimeCardsHelper
  include UsersHelper
  include ApplicationHelper
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :affiliation_id, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :affiliation_id, :admin])
  end
end