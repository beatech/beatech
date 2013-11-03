require 'open-uri'
require 'pp'

# if has_secure_password is defined in User, you can't set password_digest directly.
def disable_secure_password
  `sed -i.bak -e "s/has_secure_password/# has_secure_password/" ./app/models/user.rb`
end

def enable_secure_password
  `sed -i.bak -e "s/# has_secure_password/has_secure_password/" ./app/models/user.rb`
  `rm ./app/models/user.rb.bak`
end

disable_secure_password
begin
  databases = %w(achievements contest3rds contestdate3rds users twitter_accounts entries)
  databases.each do |database|
    puts "\nCreating #{database}..."
    valid_num, invalid_num = 0, 0

    model_class = Module.const_get(database.camelize.singularize)
    model_class.all.each { |model| model.destroy }
    JSON.parse(open("http://beatech.net/#{database}.json").read).each do |model|
      if model_class.create(model).valid?
        valid_num += 1
      else
        invalid_num += 1
      end
    end

    puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"
  end
ensure
  enable_secure_password
end

puts ''
