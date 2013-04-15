# -*- coding: utf-8 -*-
class ContestdatesController < ApplicationController
  def index
    @contestdates = Contestdate.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @contestdate = Contestdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @contestdate = Contestdate.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @order = params[:id]
    @contestdate = Contestdate.find(params[:id])
  end

  def create
    @contestdate = Contestdate.new(params[:contestdate])

    respond_to do |format|
      if @contestdate.save
        format.html { redirect_to @contestdate,
          :notice => 'Contestdate was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @contestdate = Contestdate.find(params[:id])

    respond_to do |format|
      if @contestdate.update_attributes(params[:contestdate])
        format.html { redirect_to root_url + 'contest2nd',
          :notice => '会場の編集に成功しました。' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @contestdate = Contestdate.find(params[:id])
    @contestdate.destroy

    respond_to do |format|
      format.html { redirect_to contestdates_url }
    end
  end
end
