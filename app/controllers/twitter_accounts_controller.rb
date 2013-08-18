# -*- coding: utf-8 -*-
class TwitterAccountsController < ApplicationController
  def index
    TwitterAccount.all.each do |twitter_account|
      begin
        twitter_account.destroy unless User.find(twitter_account.user_id)
      rescue
        twitter_account.destroy
      end
    end
    render json: TwitterAccount.all
  end
  
  def destroy
    @twitter_account = TwitterAccount.find_by_uid(params[:uid])
    if @twitter_account && session[:account]
      if @twitter_account.account == session[:account]
        @twitter_account.destroy
        redirect_to root_url + "users/edit/" + session[:account],
        :notice => "アカウントを削除しました。"
      else
        redirect_to root_url + 'users'
      end
    else
      redirect_to root_url + 'users'
    end
  end
end
