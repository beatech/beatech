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
  
  def edit_link
    if @entry && @entry.url
      tabs = tabs(@entry.content)
      if tabs
        link = '<li><div class="dropdown">'
        link += '<a href="#" class="dropdown-toggle" data-toggle="dropdown" id="text-dropshadow">編集 <span class="caret" style="border-top:solid 4px #FFF; margin-top:12px;"></span></a>'
        link += '<ul class="dropdown-menu"><li style="width: 160px;">'
        link += link_to @entry.title, edit_entry_path(@entry)

        tabs.each do |tab|
          link += '</li><li style="width: 160px;">'
          link += link_to Entry.find_by_url(tab).title, root_url + "edit/" + tab
        end
        
        link += '</li></ul></div></li>'
        link        
      else
        link = '<li>'
        link += link_to "編集", edit_entry_path(@entry)
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
end
