# -*- coding: utf-8 -*-
class MasterGame < ActiveRecord::Base
  attr_accessible :title, :voter, :top
  validates :title, :presence => true

  def short_title
    case self.title
    when "beatmaniaIIDX SP"          then "IIDX SP"
    when "beatmaniaIIDX DP"          then "IIDX DP"
    when "REFLEC BEAT"               then "Rb"
    when "DrumMania"                 then "DM"
    when "GuitarFreaks"              then "GF"
    when "pop'n music"               then "pop'n"
    when "Dance Dance Revolution SP" then "DDR SP"
    when "太鼓の達人"                then "太鼓"
    when "jubeat"                    then "jubeat"
    when "SOUND VOLTEX"              then "SDVX"
    when "DanceEvolution ARCADE"     then "DE"
    when "Dance Dance Revolution DP" then "DDR DP"
    when "Project DIVA Arcade"       then "DIVA"
    end
  end

  def music_title
    @master_game = MasterGame.all
    @master_music = MasterMusic.all

    @music_by_game = Array.new
    (@master_game.size).times do |i|
      # 曲ごとにループ
      @music_by_game[i] = MasterMusic.find(:all, :conditions => {:game => i})
      (@music_by_game[i].size).times do |j|
        @voter_split = @music_by_game[i][j].voter.split(",")
        @music_by_game[i][j].number = @voter_split.size
        @music_by_game[i][j].save
      end
      @music_by_game[i].sort!{|a,b| b.number <=> a.number}
    end

    @tops = Array.new
    (@master_game.size).times do |i|
      @tops[i] = MasterMusic.find(:all,
        :conditions => { :game => i, :number => @music_by_game[i][0].number})
    end

    if @tops[self.id - 1] && @tops[self.id - 1][0]
      return @tops[self.id - 1][0][:title]
    else
      return ''
    end
  end

  def url_by_account(account)
    @master_scores = MasterScore.find(:all,
      :conditions => {:account => account, :game => self.id})
    @master_score = @master_scores[0]
    return @master_score.url
  end

  def music_score_by_account(account)
    @master_score = MasterScore.find_by_account_and_game(account, self.id)
    if @master_score
      return @master_score.score
    else
      return 0
    end
  end

  def standard_score_by_account(account)
    gap = 0
    if standard_deviation != 0
      gap = (music_score_by_account(account) - average) / standard_deviation
      gap *= 10
    end

    if music_score_by_account(account) != 0
      return gap + 50
    else
      return 0
    end
  end

  def average
    sum = 0
    num = 0
    @master_scores = MasterScore.find(:all, :conditions => {:game => self.id})
    @master_scores.each do |master_score|
      if master_score.score != 0
        sum += master_score.score
        num += 1
      end
    end

    if num != 0
      return sum / num
    else
      return 0
    end
  end

  def variance
    sum = 0
    num = 0
    @master_scores = MasterScore.find(:all, :conditions => {:game => self.id})
    @master_scores.each do |master_score|
      if master_score.score != 0
        sum += (master_score.score - average)**2
        num += 1
      end
    end

    if num != 0
      return sum / num
    else
      return 0
    end
  end

  def standard_deviation
    return Math.sqrt(variance)
  end
end
