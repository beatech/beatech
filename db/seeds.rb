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

def h_level_down(text, url)
  level_down_entries = %w|tips_iidx tips_bms tips_reflec tips_sdbx tips_popn tips_taiko tips_ddr|
  level_down_entries.each do |entry_url|
    if url == entry_url 
      return text.gsub(/^\*\*/, '*').gsub(/^\*\*\*/, '**')
    end
  end
  text
end

def change_to_markdown(text)
  text = text.gsub(/^-/, '- ')
  text = text.gsub(/^(\|.+\|)h/, "\\1\n| --- | --- |")
  text = text.gsub(/\[\[(.+?)>(.+?)\]\]/, '[\1](\2)')
  text = text.gsub(/\[\[(.+?):(.+?)\]\]/, '[\1](\2)')
  text = text.gsub(/#image\((.+)\)/, '![image](\1)')
  text = text.gsub(/#youtube/, '&youtube')
  text = text.gsub(/#image-resize\((.+),[0-9]+?,[0-9]+?\)/, '![image](\1)')
  text = text.gsub(/^\*\*\*/, '###').gsub(/^\*\*/, "\n##").gsub(/^\*/, "\n#")
  text
end

puts "\nCreating entries..."
valid_num, invalid_num = 0, 0
Entry.all.each { |entry| entry.destroy }
JSON.parse(open("http://beatech.net/pages.json").read).each do |page|
  page["url"] = "users/new" if page["url"] == "registration"
  page["limit"] ||= 0
  page["text"] ||= ""
  page["menu"] ||= 0

  page["text"] = h_level_down(page["text"], page["url"])
  page["text"] = change_to_markdown(page["text"])

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
      grade: Date.today.year - user["year"].to_i - user["repeat_year"].to_i + 1,
      bio: user["short_profile"],
      profile: change_to_markdown(user["long_profile"]),
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

puts "\nCreating twitter_accounts..."
valid_num, invalid_num = 0, 0
TwitterAccount.all.each { |twitter_account| twitter_account.destroy }
JSON.parse(open("http://beatech.net/twitter_accounts.json").read).each do |twitter_account|
  if TwitterAccount.create(
      id: twitter_account["id"],
      screen_name: twitter_account["screen_name"],
      uid: twitter_account["uid"],
      user_id: twitter_account["user_id"],
  ).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"

puts "\nCreating contest3rds..."
valid_num, invalid_num = 0, 0
Contest3rd.all.each { |contest3rd| contest3rd.destroy }
JSON.parse(open("http://beatech.net/contest3rds.json").read).each do |contest3rd|
  if Contest3rd.create(contest3rd).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"

puts "\nCreating contestdate3rds..."
valid_num, invalid_num = 0, 0
Contestdate3rd.all.each { |contestdate3rd| contestdate3rd.destroy }
JSON.parse(open("http://beatech.net/contestdate3rds.json").read).each do |contestdate3rd|
  if Contestdate3rd.create(contestdate3rd).valid?
    valid_num += 1
  else
    invalid_num += 1
  end
end
puts "\e[32m#{valid_num} successes, #{invalid_num} failures\e[0m"

puts ""
