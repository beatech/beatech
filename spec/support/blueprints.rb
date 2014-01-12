require 'machinist/active_record'

Dir[Rails.root.join("spec/blueprints/*.rb")].each { |f| require f }
