# -*- coding: utf-8 -*-
class ContestdatesController < ApplicationController
  # GET /contestdates
  # GET /contestdates.json
  def index
    @contestdates = Contestdate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contestdates }
    end
  end

  # GET /contestdates/1
  # GET /contestdates/1.json
  def show
    @contestdate = Contestdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contestdate }
    end
  end

  # GET /contestdates/new
  # GET /contestdates/new.json
  def new
    @contestdate = Contestdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contestdate }
    end
  end

  # GET /contestdates/1/edit
  def edit
    @order = params[:id]
    @contestdate = Contestdate.find(params[:id])
  end

  # POST /contestdates
  # POST /contestdates.json
  def create
    @contestdate = Contestdate.new(params[:contestdate])

    respond_to do |format|
      if @contestdate.save
        format.html { redirect_to @contestdate,
          :notice => 'Contestdate was successfully created.' }
        format.json { render :json => @contestdate, :status => :created,
          :location => @contestdate }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contestdate.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contestdates/1
  # PUT /contestdates/1.json
  def update
    @contestdate = Contestdate.find(params[:id])

    respond_to do |format|
      if @contestdate.update_attributes(params[:contestdate])
        format.html { redirect_to root_url + 'contest2nd',
          :notice => '会場の編集に成功しました。' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contestdate.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contestdates/1
  # DELETE /contestdates/1.json
  def destroy
    @contestdate = Contestdate.find(params[:id])
    @contestdate.destroy

    respond_to do |format|
      format.html { redirect_to contestdates_url }
      format.json { head :no_content }
    end
  end
end
