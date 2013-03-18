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
        format.html { redirect_to root_url + 'achievements', :notice => '成果報告を送信しました。' }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def edit
    @title = "成果報告の編集"
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:achievement][:id])
    @achievement.text = params[:achievement][:text]    
    year = params[:achievement]["date(1i)"].to_i
    month = params[:achievement]["date(2i)"].to_i
    day = params[:achievement]["date(3i)"].to_i
    @achievement.date = Date.new(year, month, day)
    @achievement.save

    redirect_to root_url + 'achievements'
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy

    redirect_to(:back)
  end
end
