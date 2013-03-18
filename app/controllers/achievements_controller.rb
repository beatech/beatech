# -*- coding: utf-8 -*-
class AchievementsController < ApplicationController
  def index
    @title = "成果報告"
    @achievement = Achievement.new
    @achievement.user_id = @current_user.id if @current_user

    @achievements = Achievement.all.sort{|a, b| b.date <=> a.date }
  end  

  def create
    Page.find_by_url('achievements').touch
    @achievement = Achievement.new(params[:achievement])

    respond_to do |format|
      if @achievement.save
        format.html { redirect_to root_url + 'achievements/index', :notice => '成果報告を送信しました。' }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    @achievement.update(params)
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy

    redirect_to(:back)
  end
end
