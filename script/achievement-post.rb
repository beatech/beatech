@twitter_account = TwitterAccount.find_by_uid(ARGV[0]) if ARGV[0]

if @twitter_account && ARGV[1] && ARGV[1].length > 0
  @achievement = Achievement.new
  @achievement.user_id = @twitter_account.user_id
  @achievement.text = ARGV[1] if ARGV[1]
  @achievement.date = Date.today
  @achievement.save
end
