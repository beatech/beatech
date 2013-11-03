class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :load_entries, :authorize

  def title
    'BEATECH'
  end
  helper_method :title

  def admin_required
    raise Exception unless is_admin?
  end
  helper_method :admin_required

  def is_admin?
    return false unless @current_user
    admins = %w|ikstrm popkirby|
    admins.each do |admin|
      return true if @current_user.username == admin
    end
    false
  end
  helper_method :is_admin?

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
