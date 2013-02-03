class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  class Forbidden < StandardError; end
  private
  def authorize
    if session[:account]
      @current_member = User.find_by_account(session[:account])
      session.delete(:account) unless @current_member
    end
  end

  def login_required
    raise Forbidden unless @current_member
  end
end
