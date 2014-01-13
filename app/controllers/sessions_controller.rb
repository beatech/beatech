class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])
    if user.present?
      session[:user_id] = user.id
      redirect_to :back, notice: "ログインしました。"
    else
      redirect_to :back, notice: "ログインに失敗しました。"
    end
  end

  def destroy
    if session[:user_id].present?
      session[:user_id] = nil
      redirect_to :back, notice: "ログアウトしました。"
    else
      redirect_to :back, notice: "ログアウト済みです。"
    end
  end
end
