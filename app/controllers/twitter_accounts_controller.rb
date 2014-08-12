class TwitterAccountsController < ApplicationController
  def destroy
    twitter_account = TwitterAccount.find(params[:id])

    if twitter_account.user == @current_user
      twitter_account.destroy
      redirect_to setting_path(item: "profile"), notice: "Twitterアカウントの削除に成功しました。"
    else
      redirect_to setting_path(item: "profile"), notice: "そのTwitterアカウントの削除は許可されていません。"
    end
  end
end
