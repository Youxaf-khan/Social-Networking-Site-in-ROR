class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?
  rescue_from ::ActiveRecord::RecordNotFound, with: :render_error

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:f_name, :l_name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:f_name, :l_name, :email, :password, :current_password)}
  end

  def render_error
    render file: 'public/404.html'
  end
end
