class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_login_user

  private

  def set_login_user
    if session[:user_id]
      @login_user = User.where(id: session[:user_id]).first
      session.delete(:user_id) unless @login_user
    end
  end
end
