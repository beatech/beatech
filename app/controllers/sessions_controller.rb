class SessionsController < ApplicationController
  def index
    render 'new'
  end

  def create
    user = User.authenticate(params[:account], params[:pass])
    if user
      session[:account] = user.account
      redirect_to :root
    else
      render 'login_failure'
    end
  end

  def destroy
    session[:account] = nil
    redirect_to :root
  end
end
