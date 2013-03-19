@twitter_account = TwitterAccount.find_by_uid(ARGV[2].to_i) if ARGV[2]

if @twitter_account && ARGV[3] && ARGV[3].length > 0
  @achievement = Achievement.new
  @achievement.user_id = @twitter_account.user_id
  @achievement.text = ARGV[3] if ARGV[3]
  @achievement.date = Date.today
  @achievement.save
end

Page.find_by_url('achievements').touch
