# -*- coding: utf-8 -*-
class MasterScoresController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
    @title = "マスター部門 スコア編集"
    @master_scores = MasterScore.find(:all, :conditions => {:account => @current_user.account})
  end
  
  def update
    # 入力の登録
    params[:master_score].each do |master_score|
      game = master_score[0].to_i + 1
      @master_scores = MasterScore.find(:all, :conditions => {:account => @current_user.account, :game => game})
      @master_score = @master_scores[0]
      if @master_score
        @master_score.score = master_score[1][:score] 
        @master_score.url = master_score[1][:url]
        @master_score.save
      end
    end

    # 偏差値の計算
    update_scores

    @page = Page.find_by_url('master')
    @page.touch
    
    redirect_to root_url + 'master', :notice => 'スコアを編集しました。'
  end

  def destroy
  end

  def show
  end

  def update_scores
    @master_games = MasterGame.all
    @master_users = MasterUser.all
    
    @master_users.each do |master_user|
      account = master_user.account
      @master_games.each do |master_game|
        @master_score = MasterScore.where(:account => account, :game => master_game.id).first
        @master_score.standard_score = master_game.standard_score_by_account(account)
        @master_score.save
      end
    end    
  end
end
