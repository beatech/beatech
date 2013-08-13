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
    if /^http:\/\// =~ url
      link_to(title, url)
    else
      link_to(title, root_url + url)
    end
  end
end
