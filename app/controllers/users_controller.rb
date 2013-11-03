# coding: utf-8
class UsersController < ApplicationController
  include UsersHelper
  before_filter :admin_required, only: :destroy

  def title
    '部員紹介'
  end

  def index
    @users_grade = Array.new
    all_users = User.order('updated_at DESC')
    (0..4).each do |grade|
      @users_grade[grade] = all_users.select { |user| user.grade == grade }
    end
    @users_grade[5] = all_users.select { |user| user.grade >= 5 } # OB

    respond_to do |format|
      format.html
      format.json { render json: User.all }
    end
  end

  def show
    @user = User.find_by_username(params[:id])
    raise Exception unless @user
    @title = "#{@user.name}のプロフィール"
  end

  def new
    @user = User.new
    @user.year = Time.now.year
    @user.repeated_year = 0
    @title = '入部申請'
  end

  def create
    @user = User.new(create_user_params)
    @user.grade = grade_of(@user)
    @user.save
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    setting_items = %w|profile username password|
    if setting_items.include?(params[:item])
      render params[:item]
    else
      raise Exception
    end
  end

  def update
    case params[:item]
    when 'profile'
      @user = User.find(params[:user][:id])
      raise Exception if @user.nil? || (is_admin? == false && @current_user != @user)
      @user.update_attributes(user_params)
      @user.grade = grade_of(@user)
      if @user.save
        redirect_to @user, notice: 'プロフィールの更新に成功しました。'
      else
        render action: 'edit'
      end
    when 'username'
      @current_user.username = params[:user][:username]
      if @current_user.save
        session[:username] = params[:user][:username]
        redirect_to @current_user, notice: 'ユーザー名の更新に成功しました。'
      else
        render action: 'edit'
      end
    when 'password'
      @current_user.password = params[:user][:password]
      @current_user.password_confirmation = params[:user][:password_confirmation]
      if @current_user.save
        redirect_to @current_user, notice: 'パスワードの更新に成功しました。'
      else
        render action: 'edit'
      end
    else
      raise Exception
    end
  end

  def destroy
    User.find_by_username(params['id']).destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :year, :repeated_year, :bio, :profile, :username)
  end

  def create_user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :year, :repeated_year)
  end

  def grade_of(user)
    Date.today.year - user.year + 1
  end
end
