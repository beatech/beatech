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
end
