class TwitterAccount < ActiveRecord::Base
  attr_accessible :account, :screen_name, :uid
end
