class Redcarpet::Render::BeatechHTML < Redcarpet::Render::HTML
  include BeatechMarkdownHelper

  def header(text, level)
    level += 1
    "<h#{level}>#{text}</h#{level}>"
  end

  def postprocess(full_document)
    # youtube
    full_document.gsub!(/&amp;youtube\(http:\/\/www\.youtube\.com\/watch\?v=(.+)\)/,
      '<iframe width='560' height='315' src="http://www.youtube.com/embed/\1"' +
      ' frameborder='0' allowfullscreen></iframe>')

    # autolink (original implementation because recarpet's one is broken)
    full_document.gsub!(/([^'"])(https?:\/\/[0-9a-zA-Z.\/?=&_]+)/, '\1<a href="\2">\2</a>')

    # font
    full_document.gsub!(/&amp;color\((.+?)\){(.+?)};/, '<font color="\1">\2</font>')
    full_document.gsub!(/&amp;size\((.+?)\){(.+?)};/, '<font size="\1">\2</font>')

    # comment out
    full_document.gsub!(/^\/\/.*$/, '')
    full_document.gsub!(/([^:])\/\/.*$/, '\1')

    # expansion field
    full_document.gsub!(/&amp;expand\((.+?)\){(.+?)}/m,
        '<p class='dvtitle' onclick="ShowCBox(\'\1\')">\1</p>' +
        '<div id="developbox\1' class='developbox' onclick='ShowCBox(\'\1\')">\2</div>')

    # tab
    full_document.gsub!(/&amp;tab\(.+?\)/) do |tab_field|
      tab_list = tab_field.gsub!(/&amp;tab\((.+?)\)/, '\1')
      html = '<ul class='nav nav-tabs'>' + build_tabs(tab_list) + '</ul>'
      html += '<div class='tab-content'>' + build_tab_contents(tab_list) + '</div>'
      html
    end

    full_document
  end

  def build_tabs(tab_list)
    html = ''
    tab_list.gsub(/<(|\/)em>/, '_').split(',').each_with_index do |tab, i|
      entry = Entry.find_by_url(tab.strip)
      page_title = ''
      page_title = entry.title if entry
      if i == 0
        html += "<li class=\"active\"><a href=\"##{tab.strip}\" data-toggle=\"tab\">#{page_title}</a></li>"
      else
        html += "<li><a href=\"##{tab.strip}\" data-toggle=\"tab\">#{page_title}</a></li>"
      end
    end
    html
  end

  def build_tab_contents(tab_list)
    html = ''
    tab_list.gsub(/<(|\/)em>/, '_').split(',').each_with_index do |tab, i|
      entry = Entry.find_by_url(tab.strip)
      if i == 0
        html += "<div class=\"tab-pane active\" id=\"#{tab.strip}\">#{render_wiki_content(entry)}</div>"
      else
        html += "<div class=\"tab-pane\" id=\"#{tab.strip}\">#{render_wiki_content(entry)}</div>"
      end
    end
    html
  end
end
