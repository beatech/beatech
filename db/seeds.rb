require 'open-uri'

Entry.all.each { |entry| entry.destroy }
pages = JSON.parse(open("http://beatech.net/pages.json").read)
pages.each do |page|
  puts page["title"]
  page["limit"] ||= 0
  page["content"] ||= ""
  page["menu"] ||= 0
  Entry.create(
    title: page["title"],
    url: page["url"],
    menu: page["menu"],
    content: page["text"],
    entry_type: page["limit"],
  )
end

File.open("yaml.yml", "w") do |f|
  f << pages.to_yaml
end
