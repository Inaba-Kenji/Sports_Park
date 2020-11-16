class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  #デバイスが利用できるカラムの指定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:postal_code,:address,:age,:gender])
  end

  # sign_in後の遷移
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  # sign_out後の遷移
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
