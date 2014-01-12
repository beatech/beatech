class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])
    if user.present?
      session[:user_id] = user.id
      redirect_to :back
    else
      redirect_to :back, notice: 'ログインに失敗しました。'
    end
  end
end
