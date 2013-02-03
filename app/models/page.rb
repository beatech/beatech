class Page < ActiveRecord::Base
  attr_accessible :limit, :menu, :text, :title, :url
end
