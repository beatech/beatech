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
    @master_user.account = @current_user.account if @current_user
    @master_user.save
    
    if @master_user.name.length > 0
      redirect_to root_url + 'master', :notice => 'Master部門エントリーしました。'     
    else
      redirect_to root_url + 'master_uesrs/new', :notice => '名前を入力してください。'     
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
