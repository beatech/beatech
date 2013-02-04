# -*- coding: utf-8 -*-
class PagesController < ApplicationController
  
  # Definition of the Mode
  M_START = 0
  M_UL = 1
  M_P = 2
  M_TABLE = 3

  def convert_wiki(text)
    text.gsub!(/<(.+?)>/, '\1')                              # remove <tag>
    text.gsub!(/\[\[(.+?)>(.+?)\]\]/, '<a href="\2">\1</a>') # [[>]]
    text.gsub!(/\[\[(.+?):(.+?)\]\]/, '<a href="\2">\1</a>') # [[:]]
    text.gsub!(/[^"](http:\/\/[0-9A-Za-z\.\/#]+)/, '<a href="\1">\1</a>') # http://

    html = ""
    mode = M_START
    lines = text.split("\n")
    lines.each do |line|
      # Non-Combo Part
      if /^\*/ =~ line || /----+/ =~ line
        html = add_finish_tag(mode, html)
        
        if /^\*\*\*/ =~ line      # ***
          line.gsub!(/^\*\*\*/, "") 
          line = "<h4>" + line + "</h4>"
        elsif /^\*\*/ =~ line     # **
          line.gsub!(/^\*\*/, "")
          line = "<h3>" + line + "</h3>"
        elsif /^\*/ =~ line       # *
          line.gsub!(/^\*/, "")
          line = "<h2>" + line + "</h2>"
        elsif /----+/ =~ line     # ----
          line.gsub!(/----+/, '<hr>')
        end
        mode = M_START
        
      # Combo Part
      else        
        if /^-[^-]/ =~ line    # -
          line.gsub!(/^-/, "")          
          if mode != M_UL
            html = add_finish_tag(mode, html)
            line = "<ul><li>" + line + "</li>"
          else
            line = "<li>" + line + "</li>"
          end
          mode = M_UL
        elsif /^\|/ =~ line      # |          
          line.strip!
          bThead = false
          if /h$/ =~ line
            line.gsub!(/h$/, "")
            bThead = true
          end

          if bThead == true
            line.gsub!(/^\|/, "<th>")
            line.gsub!(/\|$/, "</th>")
            line.gsub!(/\|/, "</th><th>")
          else
            line.gsub!(/^\|/, "<td>")
            line.gsub!(/\|$/, "</td>")
            line.gsub!(/\|/, "</td><td>")
          end
          line = "<tr>" + line + "</tr>"
          if mode != M_TABLE
            html = add_finish_tag(mode, html)
            html += '<table class="style-table">'
            if bThead == true
              line = '<thead>' + line + '</thead><tbody>'
            else              
              line = '<tbody>' + line
            end
          end
          mode = M_TABLE
        else
          if mode != M_P
            html = add_finish_tag(mode, html)
            line = "<p>" + line
          end
          line += "<br>"
          mode = M_P
        end
      end
      
      html += line
    end

    html = add_finish_tag(mode, html)
    
    return html
  end

  def add_finish_tag(mode, html)
    if mode == M_UL
      html += "</ul>"
    elsif mode == M_P
      html += "</p>"
    elsif mode == M_TABLE
      html += "</tbody></table>"
    end
    return html
  end
  
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
