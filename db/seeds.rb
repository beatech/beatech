require 'open-uri'
require 'pp'

Entry.all.each { |entry| entry.destroy }
JSON.parse(open("http://beatech.net/pages.json").read).each do |page|
  print "#{page["title"]}: "
  page["limit"] ||= 0
  page["text"] ||= ""
  page["menu"] ||= 0
  p Entry.create(
    title: page["title"],
    url: page["url"],
    menu: page["menu"],
    content: page["text"],
    entry_type: page["limit"],
  ).valid?
end

User.all.each { |user| user.destroy }
JSON.parse(open("http://beatech.net/users.json").read).each do |user|
  print "#{user["account"]}: "
  p User.create(
    username: user["account"],
    password_digest: user["password_digest"],
    name: user["name"],
    year: user["year"],
    repeated_year: user["repeat_year"],
    bio: user["short_profile"],
    profile: user["long_profile"],
    profile_image: user["profile_image"],
  ).valid?
end
