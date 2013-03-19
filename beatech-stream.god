God.watch do |w|
  w.name = "beatech-stream"
  w.start = "ruby /var/www/rails/beatech/beatech-stream.rb"
  w.keepalive
end