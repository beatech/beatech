namespace :achievements do
  desc 'Fetch achievements from Twitter'
  task :fetch => :environment do
    client = Twitter::REST::Client.new do |config|
      config.bearer_token = ENV['BEARER_TOKEN']
    end

    since_id = Achievement.latest_twitter_status_id
    search_results = client.search('#BEATECH_成果報告', :count => 50, :since_id => since_id)

    search_results.each do |result|
      twitter_user = TwitterAccount.find_by_uid(result.user.id)
      next if twitter_user.nil?
      next if result.retweet?

      achievement = Achievement.new
      achievement.user_id = twitter_user.user_id
      achievement.text = result.text.gsub(/\s?\#BEATECH_成果報告/, '')
      achievement.date = result.created_at.to_date
      achievement.twitter_status_id = result.id
      achievement.save

      puts "add achievement: #{result.user.screen_name} (#{result.id}) [#{result.created_at}]: #{result.text}"
    end

    puts "Achievement entries added."
    Entry.find_by_url('achievements').touch
  end
end
