class ApplicationController < ActionController::Base
  MAX_RECENT_ENTRIES = 10

  protect_from_forgery with: :exception
  before_action :load_entries, :authorize

  def title
    'BEATECH'
  end
  helper_method :title

  def login_required
    if @current_user.blank?
      redirect_to root_path, alert: 'ログインが必要です'
      return
    end
  end

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

    @recent_entries = Entry.order(updated_at: :desc).first(MAX_RECENT_ENTRIES)
  end
end
