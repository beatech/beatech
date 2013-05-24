# -*- coding: utf-8 -*-
require 'spec_helper'

describe PagesController do
  describe '#convert_wiki' do
    it "should be able to comment out after //" do
      pages_controller = PagesController.new
      pages_controller.convert_wiki("//aaaaaa").gsub(/<.+?>/, "").should == ""
      pages_controller.convert_wiki("aaa//aaaaaa").gsub(/<.+?>/, "").should == "aaa"
    end
  end
end
