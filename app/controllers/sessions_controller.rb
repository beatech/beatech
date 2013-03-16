# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def index
    render 'new'
  end

  def twitter_create
    auth = request.env["omniauth.auth"]
    screen_name = auth[:info][:nickname]
    profile_image = auth[:info][:image]
    uid = auth[:uid]
    
    raise Forbidden unless auth
    if session[:account] == nil
      user = User.find_by_uid(uid)

      if user
        session[:account] = user.account
        redirect_to root_url
      else
        redirect_to "/registration", :notice => 'ご使用のアカウント(' +
          screen_name + ')はBEATECHアカウントに関連付けられていないようです。' +
          'お手数ですが、まずBEATECHアカンウントを作成してください。'
      end
    else
      user = User.find_by_account(session[:account])
      user.profile_image = profile_image
      user.save
      if TwitterAccount.exist?(screen_name) == true
        redirect_to(
          root_url + 'users/edit/' + session[:account],
          :notice => screen_name +
          'はすでにBEATECHアカウントに関連付けられています。'
        )
      else        
        TwitterAccount.create(
          user_id: User.find_by_account(session[:account]).id,
          uid: uid,
          screen_name: screen_name
        )
        redirect_to(
          root_url + 'users/edit/' + session[:account],
          :notice => 'アカウントを追加しました。'
        )
      end
    end
  end

  def create
    user = User.authenticate(params[:account], params[:pass])
    if user
      session[:account] = user.account
      redirect_to(:back)
    else
      redirect_to(
        root_url,
        :notice => 'ログインに失敗しました。'
      )
    end
  end

  def destroy
    session[:account] = nil
    redirect_to(:back)
  end
end
