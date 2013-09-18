class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
    @user.year = Time.now.year
    @user.repeated_year = 0
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
