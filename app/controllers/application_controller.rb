class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender_id, :age_id, :occupation_id])
  end
end
