# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  describe 'validations' do
    it "should validate uniqueness of :account" do
      2.times do
        User.create(
          name: 'hoge',
          account: 'hoge',
          password: 'hoge',
          password_confirmation: 'hoge',
          year: 2013,
          repeat_year: 2013
        )
      end
      User.where(account: 'hoge').size.should == 1
    end
  end

  describe ':account' do
    it "should be able to contain alphabets, underscore, number" do
      @user = User.create(
        name: 'hoge_2013',
        account: 'hoge',
        password: 'hoge',
        password_confirmation: 'hoge',
        year: 2013,
        repeat_year: 2013
      )
      @user.should_not == nil
    end

    # Because the part of uri after '.' is considered as format,
    # it will cause fatal error.
    it "should not contain dot" do
      @user = User.create(
        name: 'hoge.2013',
        account: 'hoge.2013',
        password: 'hoge',
        password_confirmation: 'hoge',
        year: 2013,
        repeat_year: 2013
      )
      @user.should == nil
    end

    # Because the uri that has Japanese characters isn't beautiful
    it "should not contain Japanese characters" do
      @user = User.create(
        name: 'ほげ',
        account: 'ほげ',
        password: 'hoge',
        password_confirmation: 'hoge',
        year: 2013,
        repeat_year: 2013
      )
      @user.should == nil
    end
  end
end
