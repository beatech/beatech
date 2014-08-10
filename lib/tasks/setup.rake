desc 'Setup files for development'
task 'setup' do
  Rake::Task['setup:omniauth:default'].invoke

  puts 'Checking for database.yml...'
  if !File.exists?('config/database.yml') || ENV['USE_SQLITE3']
    puts 'Use sqlite3 for db.'
    FileUtils.cp('config/database.yml.sqlite3', 'config/database.yml')
  end

  puts 'Preparing database...'
  db_tasks = %w(create migrate seed)
  db_tasks.each do |task|
    Rake::Task["db:#{task}"].invoke
  end
end

namespace 'setup' do
  desc 'Generate secret_token.rb'
  task 'secret' do
    puts 'Generating secret_token...'
    File.open('config/initializers/secret_token.rb', 'w') do |f|
      f.write "Beatech::Application.config.secret_key_base = '#{`bundle exec rake secret`}'"
    end
    puts ''
  end

  namespace 'omniauth' do
    # BEATECH for development consumer key (not for production)
    # This redirects back to http://127.0.0.1/auth/twitter/callback after authentication
    BEATECH_CONSUMER_KEY = 'N7KOrhYnHnSWBYrtMtbX0Q'
    BEATECH_CONSUMER_SECRET = 'dcTRcMn2PpwXlrO6doLclCjMOxavHQ9j9rOo5K3M78'

    def generate_omniauth_rb(consumer_key, consumer_secret)
      File.open('config/initializers/omniauth.rb', 'w') do |f|
        f.write <<-EOS
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '#{consumer_key}', '#{consumer_secret}'
end
        EOS
      end
    end

    desc 'Generate omniauth.rb with beatech for development consumer key'
    task 'default' do
      puts 'Generating omniauth configuration file...'
      puts 'Use default consumer key (BEATECH for development).'
      generate_omniauth_rb(BEATECH_CONSUMER_KEY, BEATECH_CONSUMER_SECRET)
      puts ''
    end

    desc 'Generate omniauth.rb'
    task 'manual' do
      puts 'Generating omniauth configuration file...'
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
        puts 'Use default consumer key (BEATECH for development).'
        consumer_key = BEATECH_CONSUMER_KEY
        consumer_secret = BEATECH_CONSUMER_SECRET
      end

      generate_omniauth_rb(consumer_key, consumer_secret)
      puts ''
    end
  end
end
