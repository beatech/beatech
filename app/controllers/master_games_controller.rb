# -*- coding: utf-8 -*-
class MasterGamesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @master_game = MasterGame.new
    @master_music = MasterGame.new
    @title = "対戦機種の追加"
  end

  def edit
  end

  def create
    @master_game = MasterGame.new
    @master_game.title = params[:game][:title]
    @master_game.voter = @current_user.account if @current_user
    @master_game.save
    
    @master_music = MasterMusic.new
    @master_music.title = params[:music][:title]
    @master_music.url = params[:music][:url]
    @master_music.game = @master_game.id - 1
    @master_music.author = @current_user.account if @current_user
    @master_music.voter = ''

    @master_music.save
    if @master_game.title.length > 0 && @master_music.title.length > 0
      redirect_to root_url + 'master', :notice => '対戦機種を追加しました。'     
    else
      redirect_to root_url + 'master_games/new', :notice => '機種名と譜面両方入力が必要です。'     
    end
  end
  
  def update
  end

  def destroy
  end

  def vote
    @master_game = MasterGame.find(params[:id])
    # master_game.voterに追加する
    @master_game.save
  end
end
