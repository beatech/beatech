# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  include UsersHelper
  before_filter :admin_required, only: :destroy

  def index
    @title = "部員紹介"

    @users_grade = Array.new
    all_users = User.order("updated_at DESC")
    (0..4).each do |grade|
      @users_grade[grade] = all_users.select { |user| user.grade == grade }
    end
    @users_grade[5] = all_users.select { |user| user.grade >= 5 } # OB
  end

  def show
    @user = User.find_by_username(params[:id])
    raise Exception unless @user
    @title = "#{@user.name}のプロフィール"
  end

  def new
    @user = User.new
    @user.year = Time.now.year
    @user.repeat_year = 0
    @title = "入部申請"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'        
    else
      render action: "new"
    end
  end

  def edit
    @user = User.find_by_username(params[:id])
    raise Exception unless @user
    @title = "#{@user.name}のプロフィールの編集"
  end

  def update
    @user = User.find_by_username(params[:id])
    @user.update_attributes(user_params)
    @user.grade = grade_with(params[:user][:year], params[:user][:repeated_year])
    if @user.save
      redirect_to @user, notice: 'プロフィールの更新に成功しました。'
    else
      render action: "edit"
    end
  end

  def destroy
    User.find_by_username(params["id"]).destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :year, :repeated_year, :bio, :profile)
  end
end
