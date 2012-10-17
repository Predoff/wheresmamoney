class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  before_filter :require_authentication

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_authentication
  	redirect_to welcome_path if session[:user_id].nil?
  end
end
