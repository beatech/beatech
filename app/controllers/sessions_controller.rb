# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def index
    render 'new'
  end

  def twitter_create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"])

    if user
      session[:account] = user.account
      redirect_to(:back)
    else
      redirect_to "/registration", :notice => "ご使用のアカウント(" + auth["info"]["nickname"] + ")はBEATECHアカウントに関連付けられていないようです。お手数ですが、まずBEATECHアカンウントを作成してください。"
    end
  end

  def create
    user = User.authenticate(params[:account], params[:pass])
    if user
      session[:account] = user.account
      redirect_to(:back)
    else
      render 'login_failure'
    end
  end

  def destroy
    session[:account] = nil
    redirect_to(:back)
  end
end
