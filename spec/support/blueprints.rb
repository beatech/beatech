require 'machinist/active_record'

Dir[File.expand_path('../../blueprints/*.rb', __FILE__)].each do |file|
  require file
end
