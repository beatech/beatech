# -*- coding: utf-8 -*-
class MasterUsersController < ApplicationController
  def index
  end

  def new
    @title = "Master部門にエントリー"
    @master_user = MasterUser.new    
  end

  def create
    @master_user = MasterUser.new
    @master_user.name = params[:user][:name]
    if @master_user.name.length > 0
      @master_user.account = @current_user.account if @current_user
      @master_user.save

      @master_games = MasterGame.all
      @master_games.each_with_index do |master_game, i|
        @master_score = MasterScore.new
        @master_score.account = @current_user.account if @current_user
        @master_score.score = 0
        @master_score.game = i + 1
        @master_score.url = ''
        @master_score.save
      end
      
      redirect_to root_url + 'master', :notice => 'Master部門エントリーしました。'     
    else
      redirect_to root_url + 'master_users/new', :notice => '名前を入力してください。'     
    end
  end

  def edit
    @master_user = MasterUser.find(params[:id])
  end

  def update
  end

  def destoy
  end

  def show
  end

end
