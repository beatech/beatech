class BlogsController < ApplicationController
  before_action :find_user
  before_action :set_new_comment, only: [:index, :show, :edit]
  before_action :login_required, only: [:new, :edit, :create, :update, :destroy]
  before_action :validate_user, only: [:new, :edit, :create, :update, :destroy]

  def index
    @blogs = Blog.where(user_id: @user.id).order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new(user_id: @current_user.id)
  end

  def create
    @blog = Blog.new(user_params)

    if @blog.save!
      redirect_to user_blog_path(@blog.user, @blog), notice: '記事を作成しました。'
    else
      redirect_to :back, alert: '記事の作成に失敗しました。'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update!(user_params)
      redirect_to user_blog_path(@blog.user, @blog), notice: '記事を更新しました。'
    else
      redirect_to :back, alert: '記事の更新に失敗しました。'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to user_blogs_path(@user), notice: '記事を削除しました。'
  end

  private

  def find_user
    @user = User.find_by_username(params[:user_id])
  end

  def set_new_comment
    @comment = Comment.new
  end

  def user_params
    params.require(:blog).permit(:title, :content, :user_id)
  end

  def validate_user
    if logged_in_with_invalid_user? || requested_user_id_is_invalid?
      redirect_to root_path, alert: '不正なユーザーです'
      return
    end
  end

  def logged_in_with_invalid_user?
    @current_user != @user
  end

  def requested_user_id_is_invalid?
    params[:blog].present? && params[:blog][:user_id].to_i != @current_user.id
  end
end
