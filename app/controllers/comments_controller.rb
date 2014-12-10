class CommentsController < ApplicationController
  before_action :login_required

  def create
    @comment = Comment.new(user_params)

    if @current_user.id != params[:comment][:user_id].to_i
      redirect_to root_path, alert: '不正なユーザーです'
      return
    end

    @comment.save!
    redirect_to :back, notice: 'コメントを投稿しました。'
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @current_user != @comment.user
      redirect_to root_path, alert: '不正なユーザーです'
      return
    end

    @comment.destroy
    redirect_to :back, notice: 'コメントを削除しました。'
  end

  private

  def user_params
    params.require(:comment).permit(:content, :blog_id, :user_id)
  end
end
