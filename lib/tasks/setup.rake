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
    puts 'Use default consumer key (Twitter for iPhone).'
    consumer_key = 'IQKbtAYlXLripLGPWd0HUA'
    consumer_secret = 'GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU'
  end

  File.open('config/initializers/omniauth.rb', 'w') do |f|
    f.write <<-EOS
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '#{consumer_key}', '#{consumer_secret}'
end
    EOS
  end

  puts "\nChecking for database.yml..."
  unless File.exists?('config/database.yml')
    puts 'database.yml did not exist. Use sqlite3 for db.'
    FileUtils.cp('config/database.yml.sqlite3', 'config/database.yml')
  end

  db_tasks = %w(create migrate seed)
  db_tasks.each do |task|
    Rake::Task["db:#{task}"].invoke
  end
end
