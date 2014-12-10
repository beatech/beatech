class Contestdate3rdsController < ApplicationController
  def index
    @contestdate3rds = Contestdate3rd.all
  end

  def show
    @contestdate3rd = Contestdate3rd.find(params[:id])
  end

  def new
    @contestdate3rd = Contestdate3rd.new
  end

  def edit
    @contestdate3rd = Contestdate3rd.find(params[:id])
  end

  def create
    @contestdate3rd = Contestdate3rd.new(params[:contestdate3rd])

    if @contestdate3rd.save
      redirect_to @contestdate3rd, notice: 'Contestdate3rd was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @contestdate3rd = Contestdate3rd.find(params[:id])

    if @contestdate3rd.update_attributes(params[:contestdate3rd])
      redirect_to root_url + 'contest3rd', notice: '会場の編集に成功しました。'
    else
      render action: 'edit'
    end
  end

  def destroy
    @contestdate3rd = Contestdate3rd.find(params[:id])
    @contestdate3rd.destroy

    redirect_to contestdate3rds_url
  end
end
