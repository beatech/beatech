require 'spec_helper'

describe User do
  describe '.create' do
    it "should not create user whose account name already exists" do
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

  describe 'validations' do
    it 'should validate account'
  end
end
