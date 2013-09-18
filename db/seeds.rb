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

puts "\nCreating entries..."
valid_num, invalid_num = 0, 0
Entry.all.each { |entry| entry.destroy }
JSON.parse(open("http://beatech.net/pages.json").read).each do |page|
  page["url"] = "users/new" if page["url"] == "registration"
  page["limit"] ||= 0
  page["text"] ||= ""
  page["menu"] ||= 0
  if Entry.create(
      title: page["title"],
      url: page["url"],
      menu: page["menu"],
      content: page["text"],
      entry_type: page["limit"],
      updated_at: page["updated_at"],
  ).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
#Entry.all.each do |entry|
#  entry.content = entry.content.gsub(/^\*\*/, '*').gsub(/^\*\*\*/, '**')
#  entry.save
#end
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"

puts "\nCreating users..."
valid_num, invalid_num = 0, 0
disable_secure_password
User.all.each { |user| user.destroy }
JSON.parse(open("http://beatech.net/users.json").read).each do |user|
  if User.create(
      id: user["id"],
      username: user["account"],
      password_digest: user["password_digest"],
      name: user["name"],
      year: user["year"],
      repeated_year: user["repeat_year"],
      bio: user["short_profile"],
      profile: user["long_profile"],
      profile_image: user["profile_image"],
  ).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
enable_secure_password
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"

puts "\nCreating achievements..."
valid_num, invalid_num = 0, 0
Achievement.all.each { |achievement| achievement.destroy }
JSON.parse(open("http://beatech.net/achievements.json").read).each do |achievement|
  if Achievement.create(
      id: achievement["id"],
      date: achievement["date"],
      text: achievement["text"],
      user_id: achievement["user_id"],
  ).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"
