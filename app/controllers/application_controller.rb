class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :load_entries

  def load_entries
    @circle_menu = Entry.where(menu: 1)
    @communication_menu = Entry.where(menu: 2)
    @contents_menu = Entry.where(menu: 3)
    @header_menu = Entry.where(menu: 4)

    @recent_pages = Entry.all
    @recent_pages.sort! { |a, b| b.updated_at <=> a.updated_at }
  end
end
