# -*- coding: utf-8 -*-
class MasterMusicsController < ApplicationController
  def master
    @master_game = MasterGame.all
    @master_music = MasterMusic.all
    @title = "BEATECH部内大会 Master部門"

    @author_for = Array.new
    @author_count = Array.new
    @vote_for = Array.new

    @music_by_game = Array.new
    (@master_game.size).times do |i|
      # 各ゲームに関して初期化するべきもの
      @author_for[i] = Array.new
      @author_count[i] = 0
      @vote_for[i] = 0
      5.times do |k|
        @author_for[i][k] = 0
      end

      # 曲ごとにループ
      @music_by_game[i] = MasterMusic.find(:all, :conditions => {:game => i})
      (@music_by_game[i].size).times do |j|
        # 自分が提案したものか調べる
        if @music_by_game[i][j].author == @current_user.account
          @author_for[i][@author_count[i]] = @music_by_game[i][j].id # 提案したIDを保存
          @author_count[i] += 1
        end
        
        # 投票してるか調べる
        @voter_split = @music_by_game[i][j].voter.split(",")
        @music_by_game[i][j].number = @voter_split.size 
        @music_by_game[i][j].save # あとで並列してるものを調べるため
        (@voter_split.size).times do |k|
          if @current_user && @voter_split[k].index(@current_user.account) && @voter_split[k].length == @current_user.account.length
            @vote_for[i] = @music_by_game[i][j].id # 投票してたらidをいれる
          end
        end
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
  end

  def create
    @master_music = MasterMusic.new
    @master_music.title = params[:music][:title]
    @master_music.game = params[:master_music][:game].to_i
    @master_music.author = @current_user.account if @current_user
    @master_music.voter = ''
    @master_music.save

    if @master_music.title.length > 0
      redirect_to root_url + 'master', :notice => '希望譜面を追加しました。'
    else
      redirect_to root_url + 'master_musics/new', :notice => '対戦譜面を入力してください。'
    end   
  end

  def update
  end

  def destroy
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.destroy
    redirect_to root_url + 'master', :notice => @master_music.title + 'を削除しました。'     
  end

  def vote
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.voter = @master_music.voter + @current_user.account + ','
    @master_music.save
    redirect_to root_url + 'master', :notice => @master_music.title + 'に投票しました。'     
  end

  def unvote
    @master_music = MasterMusic.find(params[:music][:id])
    @master_music.voter = @master_music.voter.gsub(@current_user.account + ',', '')
    @master_music.save
    redirect_to root_url + 'master', :notice => @master_music.title + 'への投票を取り消しました。'     
  end
end
