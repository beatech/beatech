class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :load_entries, :authorize

  def title
    "BEATECH"
  end
  helper_method :title

  def admin_required
    raise Exception unless is_admin?
  end
  helper_method :admin_required

  def is_admin?
    @current_user.try(:is_admin?)
  end
  helper_method :is_admin?

  def authorize
    if session[:username]
      @current_user = User.find_by_username(session[:username])
      session.delete(:username) unless @current_user
    end
  end

  def load_entries
    @side_menus = Menu.preload(:entries).for_side
    @header_menu = Menu.for_header.first

    @recent_entries = Entry.all
    @recent_entries.to_a.sort! { |a, b| b.updated_at <=> a.updated_at }
  end
end
