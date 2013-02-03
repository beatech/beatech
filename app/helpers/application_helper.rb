# -*- coding: utf-8 -*-
module ApplicationHelper
  def page_title
    title = "BEATECH"
    title = title + " - " + @page.title if @page.title
    if @page.url == "frontpage"
      title = "東工大音楽ゲーム愛好会BEATECH"
    end
    title
  end
end
