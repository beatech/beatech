class BlogsController < ApplicationController
  before_action :login_required, only: [:new]
  before_action :validate_user, only: [:edit, :create, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @blog = Blog.new(user_id: @current_user.id)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def validate_user
    raise Exception if @current_user.id != params[:user_id]
  end
end
