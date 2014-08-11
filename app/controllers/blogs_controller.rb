class BlogsController < ApplicationController
  before_action :login_required, only: [:new, :edit, :create, :update, :destroy]
  before_action :validate_user, only: [:new, :edit, :create, :update, :destroy]

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
    if @current_user.username != params[:user_id]
      redirect_to root_path, alert: "不正なユーザーです"
    end
  end
end
