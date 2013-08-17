# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def index
    @title = "部員紹介"

    @users_0th = User.grade(0)
    @users_1st = User.grade(1)
    @users_2nd = User.grade(2)
    @users_3rd = User.grade(3)
    @users_4th = User.grade(4)
    @users_ob  = User.ob

    @users_0th.sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_0th
    @users_1st.sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_1st
    @users_2nd.sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_2nd
    @users_3rd.sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_3rd
    @users_4th.sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_4th
    @users_ob .sort!{ |a,b| b.updated_at <=> a.updated_at } if @users_ob

    @num_0th = @users_0th.count
    @num_1st = @users_1st.count
    @num_2nd = @users_2nd.count
    @num_3rd = @users_3rd.count
    @num_4th = @users_4th.count
    @num_ob  = @users_ob .count
    @num_member = @num_1st + @num_2nd + @num_3rd + @num_4th

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: User.all }
    end
  end

  def show
    @user = User.find_by_account(params[:account])
    raise Forbidden unless @user
    @title = User.name_by_account(params[:account]) + "のプロフィール"

    this_year = Time.now.year
    this_year -= 1 if Time.now.month < 4

    grade_num = this_year - @user.year + 1 - @user.repeat_year
    @grade = case grade_num
             when 1..4 then grade_num.to_s + '年生'
             when 0 then '新入生'
             else 'OB'
             end

    @achievements = Achievement.where(user_id: @user.id)
      .sort{|a, b| b.date <=> a.date }
  end

  def edit
    @user = User.find_by_account(params[:account])
    raise Forbidden unless @user
    @title = User.name_by_account(params[:account]) + "のプロフィールの編集"
  end

  def update
    Page.find_by_url('users').touch
    @user = User.find_by_account(params[:user][:account])
    update_mail = false
    if params[:user][:mail] && @user.mail != params[:user][:mail]
      update_mail = true
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        `rails runner -e production script/mail.rb` if update_mail
        format.html { redirect_to root_url + 'users/' + @user.account,
          notice: 'プロフィールの更新に成功しました。' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    admin_required

    @user = User.find_by_account(params[:account])
    raise Forbidden unless @user
    @user.destroy
    redirect_to root_url + 'users'
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user,
          notice: 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def new
    @user = User.new
    @user.year = Time.now.year
    @user.repeat_year = 0
    @title = "入部申請"

    respond_to do |format|
      format.html
    end
  end

  def editprofile
    @user = User.find_by_account(session[:account])
    @title = "プロフィール編集"
  end

  def edit_account
    @user = User.find_by_account(session[:account])
    @title = "ユーザー名変更"
  end

  def editpassword
    @user = User.find_by_account(session[:account])
    @title = "パスワード変更"
  end

  def update_password
    @user = User.find_by_account(session[:account])
    if params[:user][:password] != params[:user][:password_confirmation]
      redirect_to(
        root_url + "settings/password",
        notice: "パスワードが確認用パスワードと一致しません。"
      )
      return
    end
    @user.password_digest = BCrypt::Password.create(params[:user][:password])
    @user.save!
    redirect_to root_url + "settings/password", notice: "パスワードを変更しました。"
  end

  def update_account
    @user = User.find(params[:user][:id])
    @user.account = params[:user][:account]
    session[:account] = params[:user][:account]
    @user.save
    redirect_to root_url + "settings/account", notice: "ユーザー名を変更しました。"
  end

  def update_profile
    @user = User.find_by_account(session[:account])
    @user.name = params[:user][:name]
    @user.profile = params[:user][:profile]
    @user.save!
    redirect_to root_url + "settings/profile", notice: "プロフィールを変更しました。"
  end

  def create_user
    @user = User.create(params[:user])
    session[:account] = @user.account

    respond_to do |format|
      if @user.save
        format.html {
          redirect_to root_url,
          notice: 'User was successfully created.'
        }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
