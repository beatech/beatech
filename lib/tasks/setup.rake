desc 'Setup files for development'
task 'setup' do
  puts 'Generating secret_token...'
  %x{echo "Beatech::Application.config.secret_key_base = '`bundle exec rake secret`'" > config/initializers/secret_token.rb}

  puts "\nGenerating omniauth configuration file..."
  puts 'Please input Twitter API Credentials.'

  print 'Consumer key (empty for default): '
  consumer_key = STDIN.gets.strip
  if consumer_key.length > 0
    consumer_secret = ''
    while consumer_secret.length == 0
      print 'Consumer secret: '
      consumer_secret = STDIN.gets.strip
    end
  else
    puts "\nUse default consumer key (Twitter for iPhone)."
    consumer_key = 'IQKbtAYlXLripLGPWd0HUA'
    consumer_secret = 'GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU'
  end

  omniauth_path = File.expand_path('./config/initializers/omniauth.rb')
  File.open(omniauth_path, 'w') do |f|
    f.write <<-EOS
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '#{consumer_key}', '#{consumer_secret}'
end
    EOS
  end

  %x{bundle exec rake db:seed}
end
