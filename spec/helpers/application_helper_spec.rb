# coding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  fixtures :entries

  describe "#title_with_entry" do
    it "should generate title with entry url" do
      title_with_entry('tips').should match(/BEATECH.*/)
    end

    it "should generate title with nil" do
      title_with_entry(nil).should match('BEATECH')
    end

    it "should return special title for frontpage" do
      title_with_entry('frontpage').should match('東工大音ゲーサークルBEATECH')
    end
  end

  describe "#entry_link" do
    it "should generate link for entry" do
      entry_link("link", "hoge").should == link_to("link", root_url + "hoge")
      entry_link("link", "http://hoge/").should == link_to("link", "http://hoge/")
    end

    it "should generate special link name for frontpage" do
      entry_link("東工大音楽ゲーム愛好会BEATECH", "frontpage").should == link_to("トップページ", root_url + "frontpage")
    end
  end

  describe "#pop_latest_date_entries" do
    it "should pop latest date entries from sorted Array of Entry" do
      @recent_entries = Entry.all
      @recent_entries.sort! { |a, b| b.updated_at <=> a.updated_at }
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
      pop_latest_date_entries.should == { date: latest_date, entries: latest_date_entries }
      @recent_entries.should == rest_entries
    end
  end
end
