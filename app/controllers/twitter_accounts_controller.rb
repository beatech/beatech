class TwitterAccountsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: TwitterAccout.all }
    end
  end
end
