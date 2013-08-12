# require 'open-uri'
# require 'json'
# require 'pp'

# pages = JSON.parse(open("http://beatech.net/pages.json").read)
# pages.each do |page|
#   puts page["title"]
#   pp page
#   Entry.create(
#     title: page["title"],
#     url: page["url"],
#     #menu: page["menu"],
#     text: page["text"],
#     menu: 0,
#     type: 3,
#     #type: page["limit"],
#   )
# end

Entry.create(title: "a", url: "a", text: "a", menu: 0, type: 0)
