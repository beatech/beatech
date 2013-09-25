class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin_required, :is_admin?
  before_filter :load_entries, :authorize

  def admin_required
    raise Exception unless is_admin?
  end
  
  def is_admin?
    return false unless @current_user
    admins = %w|ikstrm popkirby|
    admins.each do |admin|
      return true if @current_user.username == admin
    end
    false
  end

  def authorize
    if session[:username]
      @current_user = User.find_by_username(session[:username])
      session.delete(:username) unless @current_user
    end
  end

  def load_entries
    @circle_menu = Entry.where(menu: 1)
    @communication_menu = Entry.where(menu: 2)
    @contents_menu = Entry.where(menu: 3)
    @header_menu = Entry.where(menu: 4)

    @recent_entries = Entry.all
    @recent_entries.sort! { |a, b| b.updated_at <=> a.updated_at }
  end
end
