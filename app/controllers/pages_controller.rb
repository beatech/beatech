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
    text.gsub!(/#youtube\(http:\/\/www\.youtube\.com\/watch\?v=(.+?)\)/, '<iframe width="560" height="315" src="http://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe>') # #youtube()
    text.gsub!(/#image\((.+?)\)/, '<img src="\1">') #        #image()
    text.gsub!(/#image-resize\((.+?),(.+?),(.+?)\)/, '<img src="\1" width="\2" height="\3">') # #image()
    text.gsub!(/([^"])(http:\/\/[0-9A-Za-z\.\/#]+)/, '\1<a href="\2">\2</a>') # http://
    text.gsub!(/&color\((.+?),(.+?)\){(.+?)};/, '<span style="color:\1; background-color:\2">\3</span>')       # &color
    text.gsub!(/&color\((.+?)\){(.+?)};/, '<font color="\1">\2</font>')       # &color
    text.gsub!(/&size\((.+?)\){(.+?)};/, '<font size="\1">\2</font>')       # &size


    html = ""
    mode = M_START
    expand_count = 0
    lines = text.split("\n")
    lines.each do |line|
      # Comment out
      line.gsub!(/([^:])\/\/.*$/, "\1")
      
      # Non-Combo Part
      if /^\*/ =~ line || /----+/ =~ line || /^}/ =~ line || /^&expand\(.+\){/ =~ line || /^&tab\(.+\)/ =~ line

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
        elsif /^----+/ =~ line     # ----
          line.gsub!(/^----+/, '<hr>')
        elsif /^&expand\(.+\){/ =~ line
          line.gsub!(/^&expand\((.+)\){/, '<p class="dvtitle" onclick="ShowCBox(' + expand_count.to_s + ')" style="margin:0 0 3px 0">\1</p><div id="developbox' + expand_count.to_s + '" class="developbox" onclick="ShowCBox(' + expand_count.to_s + ')">')
          expand_count += 1
        elsif /^}/ =~ line     # };
          line.gsub!(/^}/, '</div>')
        elsif /^&tab\(.+\)/ =~ line
          tabs = line.gsub(/^&tab\(/, "").gsub(/\)/, "").strip.split(",")
          
          line = '<ul class="nav nav-tabs">'
          tab_name = 'tab'
          tabs.each_with_index do |tab, i|
            if i == 0
              tab_name = tab.strip
              line += '<li class="active"><a href="#' + tab_name + i.to_s + '" data-toggle="tab">' + Page.title_by_url(tab.strip) + '</a></li>'
            else
              line += '<li><a href="#' + tab_name + i.to_s + '" data-toggle="tab">' + Page.title_by_url(tab.strip) + '</a></li>'
            end
          end
          line += '</ul>'

          tabs.each_with_index do |tab, i|
            if i == 0
              line += '<div class="tab-content"><div class="tab-pane active" id="' + tab_name + i.to_s + '">'
              @tab_page = Page.find_by_url(tab.strip)
              line += convert_wiki(@tab_page.text)
              line += '</div>'
            else
              line += '<div class="tab-pane" id="' + tab_name + i.to_s + '">'
              @tab_page = Page.find_by_url(tab.strip)
              line += convert_wiki(@tab_page.text)
              line += '</div>'
            end
          end
          line += '</div>'
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
    admin_required
    
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
    @title = "ページの新規作成"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  def frontpage
    @page = Page.find_by_url("frontpage")
    if @page
      @text = @page.text
      @text = convert_wiki(@text)
    else
      @text = "No frontpage"
    end
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
