# -*- coding: utf-8 -*-
class Contest2ndsController < ApplicationController
  def result
    @contest2nds = Contest2nd.all
    @contestdates = Contestdate.all
    @a_team = Contest2nd.find(:all, :conditions => {:team => 'A'})
    @b_team = Contest2nd.find(:all, :conditions => {:team => 'B'})
    @c_team = Contest2nd.find(:all, :conditions => {:team => 'C'})
    @title = '第二回部内大会'
  end

  def tunesedit
    @order = params[:order]
    @tunes = Array.new
    @a_team = Contest2nd.find(:all, :conditions => {:team => 'A', :order => @order})
    @tunes[0] = @a_team[0]
    @b_team = Contest2nd.find(:all, :conditions => {:team => 'B', :order => @order})
    @tunes[1] = @b_team[0]
    @c_team = Contest2nd.find(:all, :conditions => {:team => 'C', :order => @order})
    @tunes[2] = @c_team[0]
  end

  def tunesupdate
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      if @contest2nd.update_attributes(params[:contest2nd])
        format.html { redirect_to @contest2nd, :notice => 'Contest2nd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contest2nd.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  # GET /contest2nds
  # GET /contest2nds.json
  def index
    @contest2nds = Contest2nd.all
    @title = 'データ編集'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contest2nds }
    end
  end

  # GET /contest2nds/1
  # GET /contest2nds/1.json
  def show
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  # GET /contest2nds/new
  # GET /contest2nds/new.json
  def new
    @contest2nd = Contest2nd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contest2nd }
    end
  end

  # GET /contest2nds/1/edit
  def edit
    @contest2nd = Contest2nd.find(params[:id])
  end

  # POST /contest2nds
  # POST /contest2nds.json
  def create
    @contest2nd = Contest2nd.new(params[:contest2nd])

    respond_to do |format|
      if @contest2nd.save
        format.html { redirect_to @contest2nd, :notice => 'Contest2nd was successfully created.' }
        format.json { render :json => @contest2nd, :status => :created, :location => @contest2nd }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contest2nd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contest2nds/1
  # PUT /contest2nds/1.json
  def update
    @contest2nd = Contest2nd.find(params[:id])

    respond_to do |format|
      if @contest2nd.update_attributes(params[:contest2nd])
        format.html { redirect_to @contest2nd, :notice => 'Contest2nd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contest2nd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contest2nds/1
  # DELETE /contest2nds/1.json
  def destroy
    @contest2nd = Contest2nd.find(params[:id])
    @contest2nd.destroy

    respond_to do |format|
      format.html { redirect_to contest2nds_url }
      format.json { head :no_content }
    end
  end
end
