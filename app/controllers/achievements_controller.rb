# coding: utf-8
class AchievementsController < ApplicationController
  def title
    "成果報告"
  end

  def index
    @achievement = Achievement.new
    @achievement.user_id = @current_user.id if @current_user

    @achievements = Achievement.order("date DESC").page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: Achievement.all }
    end
  end

  def create
    Entry.find_by_url("achievements").touch
    @achievement = Achievement.new(user_params)
    @achievement.user = @current_user

    if @achievement.save
      redirect_to achievements_path, notice: "成果報告を送信しました。"
    else
      render action: "index"
    end
  end

  def edit
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

    redirect_to root_url + "achievements"
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy

    redirect_to :back
  end

  private
  def user_params
    params.require(:achievement).permit(:date, :text)
  end
end
