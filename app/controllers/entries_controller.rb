# coding: utf-8
class EntriesController < ApplicationController
  layout 'frontpage', only: :frontpage

  def title
    if @entry && @entry.title
      case @entry.url
      when 'frontpage' then '東工大音ゲーサークルBEATECH'
      else "BEATECH - #{@entry.title}"
      end
    else
      'BEATECH'
    end
  end

  def index
    @entries = Entry.all
    @title = 'ページ一覧'
  end

  def show
    @entry = Entry.find_by_url(params[:id])
  end

  def new
    @entry = Entry.new
    @title = 'ページの新規作成'
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = Entry.new(user_params)
    @entry.entry_type = 0

    if @entry.save
      redirect_to edit_entry_path(@entry.url), notice: 'ページの作成に成功しました。'
    else
      redirect_to new_entry_path
    end
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update_attributes(user_params)
      redirect_to entry_path(@entry.url), notice: 'ページを更新しました。'
    else
      redirect_to edit_entry_path(@entry.url)
    end
  end

  def destroy
    admin_required

    @entry = Entry.find_by_id(params[:id])
    @entry.destroy
    redirect_to entries_path
  end

  def frontpage
    @entry = Entry.find_by_url('frontpage')
    @entry ||= Entry.create(
      title: '東工大音楽ゲーム愛好会BEATECH',
      url: 'frontpage',
      content: 'This is automatically generated frontpage.',
      entry_type: 0,
      menu_id: nil,
    )
    render action: 'show'
  end

  private

  def user_params
    params.require(:entry).permit(:title, :url, :content, :menu_id)
  end
end
