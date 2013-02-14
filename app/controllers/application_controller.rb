class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize, :load_pages

  class Forbidden < StandardError; end
  private
  def authorize
    if session[:account]
      @current_user = User.find_by_account(session[:account])
      session.delete(:account) unless @current_user
    end
  end

  def login_required
    raise Forbidden unless @current_user
  end

  def admin_required
    unless @current_user
      raise Forbidden
    end
    
    unless @current_user.account == 'ikstrm'
       raise Forbidden
    end
  end

  def load_pages
    @circle_menu = Page.find(:all, :conditions => { :menu => 1})
    @communication_menu = Page.find(:all, :conditions => { :menu => 2})
    @contents_menu = Page.find(:all, :conditions => { :menu => 3})
    @header_menu = Page.find(:all, :conditions => { :menu => 4})
    
    @recent_pages = Page.all
    @recent_pages.sort!{|a,b| b.updated_at <=> a.updated_at}
  end
end
