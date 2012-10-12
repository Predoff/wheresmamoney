class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_user
    User.find 1
  end
end
