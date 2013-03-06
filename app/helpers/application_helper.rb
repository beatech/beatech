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
end
