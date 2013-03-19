# -*- coding: utf-8 -*-
require 'user_stream'
require 'twitter'
require 'pp'

UserStream.configure do |config|
  # beatech
  config.consumer_key = 'IQKbtAYlXLripLGPWd0HUA'
  config.consumer_secret = 'GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU'
  config.oauth_token = '519603858-RlouKGFjTkpkXS8Zgo8bW1ydG5H8E19upSvPPmLa'
  config.oauth_token_secret = 'lh37YBtSIk8sbcfiX3HH5BlKGSXf6JWPV2iL0ihQ74'
end

Twitter.configure do |config|
  # beatech
  config.consumer_key = 'IQKbtAYlXLripLGPWd0HUA'
  config.consumer_secret = 'GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU'
  config.oauth_token = '519603858-RlouKGFjTkpkXS8Zgo8bW1ydG5H8E19upSvPPmLa'
  config.oauth_token_secret = 'lh37YBtSIk8sbcfiX3HH5BlKGSXf6JWPV2iL0ihQ74'
end

client = UserStream.client
client.user do |status|
  if status["text"] && status["text"].index("#BEATECH_成果報告")
    command = 'rails runner script/achievement-post.rb ' + status["user"]["id"].to_s + ' "' + status["text"].gsub(/#BEATECH_成果報告/, "") + '"'
    puts '実行: ' + command
    system(command)
  end
end

