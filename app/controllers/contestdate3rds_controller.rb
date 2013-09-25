# -*- encoding: utf-8 -*-
class Contestdate3rdsController < ApplicationController
  # GET /contestdate3rds
  # GET /contestdate3rds.json
  def index
    @contestdate3rds = Contestdate3rd.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contestdate3rds }
    end
  end

  # GET /contestdate3rds/1
  # GET /contestdate3rds/1.json
  def show
    @contestdate3rd = Contestdate3rd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /contestdate3rds/new
  # GET /contestdate3rds/new.json
  def new
    @contestdate3rd = Contestdate3rd.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /contestdate3rds/1/edit
  def edit
    @contestdate3rd = Contestdate3rd.find(params[:id])
  end

  # POST /contestdate3rds
  # POST /contestdate3rds.json
  def create
    @contestdate3rd = Contestdate3rd.new(params[:contestdate3rd])

    respond_to do |format|
      if @contestdate3rd.save
        format.html { redirect_to @contestdate3rd, notice: 'Contestdate3rd was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /contestdate3rds/1
  # PUT /contestdate3rds/1.json
  def update
    @contestdate3rd = Contestdate3rd.find(params[:id])

    respond_to do |format|
      if @contestdate3rd.update_attributes(params[:contestdate3rd])
        format.html { redirect_to root_url + 'contest3rd',
                      :notice => '会場の編集に成功しました。' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /contestdate3rds/1
  # DELETE /contestdate3rds/1.json
  def destroy
    @contestdate3rd = Contestdate3rd.find(params[:id])
    @contestdate3rd.destroy

    respond_to do |format|
      format.html { redirect_to contestdate3rds_url }
    end
  end
end
