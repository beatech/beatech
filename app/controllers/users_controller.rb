# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @title = "入部申請"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def editprofile
    @user = User.find_by_account(session[:account])
    @title = "プロフィール編集"
  end

  def editpassword
    @user = User.find_by_account(session[:account])
    @title = "パスワード変更"
  end

  def showprofile
    @user = User.find_by_account(params[:account])
    @title = "プロフィール"
    @title = @user.name + "さんのページ" if @user && @user.name

    if params[:password]
      update      
    end
    raise Forbidden unless @user
  end  

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_password
    @user = User.find_by_account(session[:account])
    if params[:user][:password] != params[:user][:password_confirmation]
      redirect_to root_url + "settings/password", :notice => "パスワードが確認用パスワードと一致しません。"
      return
    end
    @user.password_digest = BCrypt::Password.create(params[:user][:password])
    @user.save!
    redirect_to root_url + "settings/password", :notice => "パスワードを変更しました。"
  end
  
  def update_profile
    @user = User.find_by_account(session[:account])
    @user.name = params[:user][:name]
    @user.profile = params[:user][:profile]
    @user.save!
    redirect_to root_url + "settings/profile", :notice => "プロフィールを変更しました。"
  end

  def create_user
    @user = User.create(params[:user])
    session[:account] = @user.account

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
