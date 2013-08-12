require 'open-uri'
require 'json'

Entry.all.each { |entry| entry.destroy }
pages = JSON.parse(open("http://beatech.net/pages.json").read)
pages.each do |page|
  puts page["title"]
  Entry.create(
    title: page["title"],
    url: page["url"],
    menu: page["menu"],
    text: page["text"],
    entry_type: page["limit"],
  )
end

