# -*- coding: utf-8 -*-
module ApplicationHelper
  def title_with_entry(url)
    if url == 'frontpage'
      '東工大音ゲーサークルBEATECH'
    else
      'BEATECH'
    end
  end

  def entry_link(title, url)
    title = 'トップページ' if url == 'frontpage'
    if /^http:\/\// =~ url
      link_to(title, url)
    else
      link_to(title, root_url + url)
    end
  end

  def pop_latest_date_entries
    latest_date = @recent_entries.first.updated_at.to_date
    latest_date_entries = Array.new
    rest_entries = Array.new
    @recent_entries.each do |entry|
      if entry.updated_at.to_date == latest_date
        latest_date_entries << entry
      else
        rest_entries << entry
      end
    end
    @recent_entries = rest_entries
    { date: latest_date, entries: latest_date_entries }
  end

  def render_wiki_content(entry)
    render_wiki(entry.content)
  end

  def render_wiki(text)
    convert_wiki(text).html_safe
  end

  M_START = 0
  M_UL = 1
  M_P = 2
  M_TABLE = 3

  def convert_wiki(text)
    text.gsub!(/<(.+?)>/, '\1')                              # remove <tag>
    text.gsub!(/\[\[(.+?)>(.+?)\]\]/, '<a href="\2">\1</a>') # [[>]]
    text.gsub!(/\[\[(.+?):(.+?)\]\]/, '<a href="\2">\1</a>') # [[:]]
    text.gsub!(/#youtube\(http:\/\/www\.youtube\.com\/watch\?v=(.+?)\)/,
      '<iframe width="560" height="315" src="http://www.youtube.com/embed/\1"' +
      'frameborder="0" allowfullscreen></iframe>')           # #youtube()
    text.gsub!(/#image\((.+?)\)/, '<img src="\1">')          # #image()
    text.gsub!(/#image-resize\((.+?),(.+?),(.+?)\)/,
      '<img src="\1" width="\2" height="\3">')               # #image()
    text.gsub!(/([^"])(http:\/\/[0-9A-Za-z\.\/#]+)/,
      '\1<a href="\2">\2</a>')                               # http://
    text.gsub!(/&color\((.+?),(.+?)\){(.+?)};/,
      '<span style="color:\1; background-color:\2">\3</span>')          # &color
    text.gsub!(/&color\((.+?)\){(.+?)};/, '<font color="\1">\2</font>') # &color
    text.gsub!(/&size\((.+?)\){(.+?)};/, '<font size="\1">\2</font>')   # &size

    html = ""
    mode = M_START
    expand_count = 0
    lines = text.split("\n")
    lines.each do |line|
      line.gsub!(/^\/\/.*$/, "")
      line.gsub!(/([^:])\/\/.*$/, '\1')

      if /^\*/ =~ line || /----+/ =~ line || /^}/ =~ line ||
          /^&expand\(.+\){/ =~ line || /^&tab\(.+\)/ =~ line

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
          line.gsub!(/^&expand\((.+)\){/,
            '<p class="dvtitle" onclick="ShowCBox(' + expand_count.to_s +
            ')" style="margin:0 0 3px 0">\1</p><div id="developbox' +
            expand_count.to_s + '" class="developbox" onclick="ShowCBox(' +
            expand_count.to_s + ')">')
          expand_count += 1
        elsif /^}/ =~ line     # };
          line.gsub!(/^}/, '</div>')
        elsif /^&tab\(.+\)/ =~ line
          tabs = line.gsub(/^&tab\(/, "").gsub(/\)/, "").strip.split(",")

          line = '<ul class="nav nav-tabs">'
          tab_name = 'tab'
          tabs.each_with_index do |tab, i|
            entry = Entry.find_by_url(tab.strip)
            if i == 0
              tab_name = tab.strip
              if entry
                line += '<li class="active"><a href="#' + tab_name + i.to_s +
                  '" data-toggle="tab">' + entry.title + '</a></li>'
              else
                i -= 1
              end
            else
              if entry
                line += '<li><a href="#' + tab_name + i.to_s +
                  '" data-toggle="tab">' + entry.title + '</a></li>'
              end
            end
          end
          line += '</ul>'

          tabs.each_with_index do |tab, i|
            if i == 0
              line += '<div class="tab-content">'
              line += '<div class="tab-pane active" id="'
              line += tab_name + i.to_s + '">'
              @tab_page = Entry.find_by_url(tab.strip)
              line += convert_wiki(@tab_page.content) if @tab_page
              line += '</div>'
            else
              line += '<div class="tab-pane" id="' + tab_name + i.to_s + '">'
              @tab_page = Entry.find_by_url(tab.strip)
              line += convert_wiki(@tab_page.content) if @tab_page
              line += '</div>'
            end
          end
          line += '</div>'
        end
        mode = M_START
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
    add_finish_tag(mode, html)
  end

  def add_finish_tag(mode, html)
    case mode
    when M_UL
      html += "</ul>"
    when M_P
      html += "</p>"
    when M_TABLE
      html += "</tbody></table>"
    end
    html
  end
end
