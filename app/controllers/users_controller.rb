class UsersController < ApplicationController
  include UsersHelper
  before_filter :admin_required, only: :destroy

  def title
    '部員紹介'
  end

  def index
    @users_by_grade = User.preload(:twitter_accounts).order(updated_at: :desc).group_by(&:grade)
    @active_members_count = @users_by_grade.slice(1, 2, 3, 4).values.flatten.size

    # FIXME: grade over User::GRADE_OB should be GRADE_OB
    ob_grades = @users_by_grade.keys.select { |grade| grade >= User::GRADE_OB }
    @users_by_grade[User::GRADE_OB] = @users_by_grade.slice(*ob_grades).values.flatten
  end

  def show
    @user = User.find_by_username(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
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
    if @user.save
      session[:username] = @user.username
      redirect_to @user, notice: '部員登録に成功しました。BEATECHへようこそ！'
    else
      flash[:alert] = @user.errors.full_messages.join
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
end
