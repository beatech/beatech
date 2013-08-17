# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:username] = user.username
      redirect_to :back
    else
      redirect_to root_url, notice: 'ログインに失敗しました。'
    end
  end

  def destroy
    session[:username] = nil
    redirect_to :back
  end
end
