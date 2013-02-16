# -*- coding: utf-8 -*-
class MasterGamesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @master_game = MasterGame.new
    @title = "対戦機種の追加"
  end

  def edit
  end

  def create
    @master_game = MasterGame.new(params[:master_page])
    @page.save
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
