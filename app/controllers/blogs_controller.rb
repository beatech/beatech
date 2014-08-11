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
    @blog = Blog.new(user_params)

    if @blog.save!
      redirect_to user_blog_path(@blog.user, @blog), notice: "記事を作成しました。"
    else
      redirect_to :back, alert: "記事の作成に失敗しました。"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:blog).permit(:title, :content, :user_id)
  end

  def validate_user
    if logged_in_with_invalid_user? || requested_user_id_is_invalid?
      redirect_to root_path, alert: "不正なユーザーです"
    end
  end

  def logged_in_with_invalid_user?
    @current_user.username != params[:user_id]
  end

  def requested_user_id_is_invalid?
    params[:blog].present? && params[:blog][:user_id].to_i != @current_user.id
  end
end
