class TwitterAccountsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: TwitterAccount.all }
    end
  end
end
