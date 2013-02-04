# -*- coding: utf-8 -*-
class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @page.limit = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  def frontpage
    @page = Page.find_by_url("frontpage")
    raise Forbidden unless @page
    @text = @page.text
    @text = convert_wiki(@text)
    render "show_page"
  end

  def show_page
    @page = Page.find_by_url(params[:url])
    raise Forbidden unless @page
    @text = @page.text
    @text = convert_wiki(@text)
  end

  def convert_wiki(text)
    text.gsub!(/<(.+?)>/, '\1')
    text.gsub!(/\[\[(.+?)>(.+?)\]\]/, '<a href="\2">\1</a>')
    text.gsub!(/\[\[(.+?):(.+?)\]\]/, '<a href="\2">\1</a>')
    lines = text.split("\n")    

    html = ""
    lines.each do |line|
      if /^\*\*\*/ =~ line
        line.gsub!(/^\*\*\*/, "")
        line = "<h4>" + line + "</h4>"
      elsif /^\*\*/ =~ line
        line.gsub!(/^\*\*/, "")
        line = "<h3>" + line + "</h3>"
      elsif /^\*/ =~ line
        line.gsub!(/^\*/, "")
        line = "<h2>" + line + "</h2>"
      else
        line += "<br>"
      end
        
      html += line
    end

    return html
  end

  def edit_page
    @page = Page.find_by_url(params[:url])
    raise Forbidden unless @page
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to root_url + @page.url, :notice => 'ページの作成に成功しました。' }
        # format.json { render :json => root_url, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        # format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end                        
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to root_url + @page.url, :notice => 'ページを更新しました。' }
        # format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        # format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
