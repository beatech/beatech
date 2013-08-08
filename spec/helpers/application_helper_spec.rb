# -*- coding: utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do
  describe "title_with_entry" do
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
end
