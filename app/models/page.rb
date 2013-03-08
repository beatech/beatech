class Page < ActiveRecord::Base
  attr_accessible :limit, :menu, :text, :title, :url

  def self.title_by_url(url)
    @page = Page.find_by_url(url)
    
    if @page
      @page.title
    else
      nil
    end
  end
end
