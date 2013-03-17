# -*- coding: utf-8 -*-
module ApplicationHelper
  def page_title
    title = "BEATECH"
    if @page && @page.title
      title = title + " - " + @page.title
      if @page.url == "frontpage"
        title = "東工大音楽ゲーム愛好会BEATECH"
      end
    end
    title
  end

  def page_link(title, url)
    if /^http:\/\// =~ url
      link_to(title, url)
    else
      link_to(title, root_url + url)
    end
  end

  def edit_link
=begin    
    '<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="text-dropshadow"><%= @current_user.account %> <span class="caret"></span></a>'
    '<ul class="dropdown-menu">'
    '<li><%= link_to "プロフィールを編集", root_url + "settings/profile" %></li>'
    '<li><%= link_to "パスワード変更", root_url + "settings/password" %></li>'
    '<li class="divider"></li>'
    '<li><%= link_to 'ログアウト', session_path(@current_user.account), :method => :delete %></li>'
    '</ul>'
=end
    if @page && @page.url
      tabs = tabs(@page.text)
      if tabs
        link = '<li><div class="dropdown">'
        link += '<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="text-dropshadow">編集 <span class="caret" style="border-top:solid 4px #FFF; margin-top:12px;"></span></a>'
        link += '<ul class="dropdown-menu"><li style="width: 160px;">'
        link += link_to @page.title, root_url + "edit/" + @page.url

        tabs.each do |tab|
          link += '</li><li style="width: 160px;">'
          link += link_to Page.title_by_url(tab), root_url + "edit/" + tab
        end
        
        link += '</li></ul></div></li>'
        link        
      else
        link = '<li>'
        link += link_to "編集", root_url + "edit/" + @page.url
        link += '</li>'
        link
      end
    else
      ''
    end
  end

  def tabs(text)
    if text
      if text =~/&tab\(.+\)/
        $&.gsub(/^&tab\(/, "").gsub(/\)/, "").strip.split(",")
      else
        nil
      end
    else
      nil
    end
  end
end
