# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
  def show
    raise params.to_yaml
    @entry = Entry.find_by_url(params[:id])
  end

  def frontpage
    @entry = Entry.find_by_url("frontpage")
    @entry ||= Entry.create(
      title: "東工大音楽ゲーム愛好会BEATECH",
      url: "frontpage",
      content: "This is automatically generated frontpage.",
      entry_type: 0,
      menu: 0,
    )
    render action: "show"
  end
end
