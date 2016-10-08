namespace :users do
  desc 'Fetch profile image from Twitter account'
  task :fetch_profile_image => :environment do
    client = Twitter::REST::Client.new do |config|
      config.bearer_token = ENV['BEARER_TOKEN']
    end

    ActiveRecord::Base.record_timestamps = false
    User.all.each do |user|
      twitter_account = user.twitter_accounts.first
      if twitter_account.present?
        print "#{user.name}: "
        begin
          profile_image_url = client.user(twitter_account.uid.to_i, :skip_status => true).profile_image_url
          user.profile_image = profile_image_url.to_s if profile_image_url.present?
          user.save
          puts 'success'
        rescue => e
          puts 'error'
          puts e
        end
        sleep(1)
      end
    end

    ActiveRecord::Base.record_timestamps = true
  end
end
