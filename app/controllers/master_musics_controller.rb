# -*- coding: utf-8 -*-
class MasterMusicsController < ApplicationController
  def master    
    # なかったら初期化
    @master_score = MasterScore.find(1)
    if @master_score.standard_score == nil
      master_controller = MasterScoresController.new
      master_controller.update_scores
    end
    
    # エントリー
    @bEntried = false
    @bEntriable = false
    if @current_user
      if MasterUser.find_by_account(@current_user.account)
        @bEntried = true
      else
        @bEntriable = true
      end
    end

    # 参加者表示
    @master_users = MasterUser.all
    @master_users.sort!{|a,b| b.total_standard_score <=> a.total_standard_score}    
    
    # ページ表示
    @page = Page.find_by_url("master")
    controller = PagesController.new
    @text = controller.convert_wiki(@page.text) if @page && @page.text

    # 以下は投票用
    @master_game = MasterGame.all
    @master_music = MasterMusic.all
    @title = "BEATECH部内大会 Master部門"

    @music_by_game = Array.new
    (@master_game.size).times do |i|
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
      @tops[i] = MasterMusic.find(:all, :conditions => { :game => i, :number => @music_by_game[i][0].number})
    end
  end
  
  def index
  end

  def show
  end

  def new
    @master_games = MasterGame.all
    @game = params[:id]
    @master_music = MasterMusic.new
    @master_music.game = @game
    @title = @master_games[@game.to_i].title + " の譜面の追加"
  end

  def edit
    @music = MasterMusic.find(params[:music][:id])
    @title = @music.title + "の編集"
  end

  def create
    @master_music = MasterMusic.new
    @master_music.title = params[:music][:title]
    @master_music.url = params[:music][:url]
    @master_music.game = params[:master_music][:game].to_i
    @master_music.author = @current_user.account if @current_user
    @master_music.voter = ''
    @master_music.save

    @page = Page.find_by_url('master')
    @page.touch

    if @master_music.title.length > 0
      redirect_to root_url + 'master', :notice => '希望譜面を追加しました。'
    else
      redirect_to root_url + 'master_musics/new', :notice => '譜面名を入力してください。'
    end
  end

  def update
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.title = params[:music][:title]
    @master_music.url = params[:music][:url]
    @master_music.save

    @page = Page.find_by_url('master')
    @page.touch
    
    if @master_music.title.length > 0
      redirect_to root_url + 'master', :notice => '希望譜面を編集しました。'
    else
      redirect_to root_url + 'master_musics/update', :notice => '譜面名を入力してください。'
    end
  end

  def destroy
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.destroy

    @page = Page.find_by_url('master')
    @page.touch

    redirect_to root_url + 'master', :notice => @master_music.title + 'を削除しました。'     
  end

  def vote
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.voter = @master_music.voter + @current_user.account + ','
    @master_music.save

    @page = Page.find_by_url('master')
    @page.touch
    
    redirect_to root_url + 'master', :notice => @master_music.title + 'に投票しました。'     
  end

  def unvote
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.voter = @master_music.voter.gsub(@current_user.account + ',', '')
    @master_music.save

    @page = Page.find_by_url('master')
    @page.touch
    
    redirect_to root_url + 'master', :notice => @master_music.title + 'への投票を取り消しました。'     
  end

  def ajax_data 
    users = MasterUser.all.sort{|a,b| b.total_standard_score <=> a.total_standard_score}
    score = []
    total_sscores = []
    averages = []
    games = MasterGame.all
    users.each do |user|
      user_score = []
      games.each do |game|
        user_score.push(MasterScore.find_by_account_and_game(user.account, game.id))
      end
      score.push(user_score)
      total_sscores.push(user.total_standard_score);
    end

    games.each do |game|
      averages.push(game.average)
    end

    render :json => {
      :music => MasterMusic.all,
      :users => users,
      :score => score,
      :games => games,
      :total_sscores => total_sscores,
      :averages => averages
    }
  end
end
