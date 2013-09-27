require 'spec_helper'

describe UsersController do
  describe '#create' do
    context 'given valid params' do
      let(:user) do
        { name: 'foo', username: 'foo', password: 'bar', password_confirmation: 'bar', year: 2013, repeated_year: 0 }
      end

      it 'creates a user' do
        post :create, user: user
        User.find_by_username('foo').should_not be_nil
      end
    end

    context 'given invalid params' do
      let(:user) do
        { name: 'foo', username: 'foo', password: 'bar', password_confirmation: 'foo', year: 2013, repeated_year: 0 }
      end

      it 'does not create a user' do
        post :create, user: user
        User.find_by_username('foo').should be_nil
      end
    end
  end

  describe '#update' do
    context 'when editing profile' do
      let!(:user) do
        User.create(name: 'foo', username: 'foo', password: 'foo', password_confirmation: 'foo', year: 2013, repeated_year: 0)
      end

      before do
        controller.instance_variable_set(:@current_user, user)
      end

      it 'updates profile' do
        patch :update, item: 'profile', user: user.attributes.merge(name: 'hoge')
        User.find(user.id).name.should == 'hoge'
      end
    end

    context 'when editing username' do
      let!(:user) do
        User.create(name: 'foo', username: 'foo', password: 'foo', password_confirmation: 'foo', year: 2013, repeated_year: 0)
      end

      before do
        controller.instance_variable_set(:@current_user, user)
      end

      it 'updates username' do
        patch :update, item: 'username', user: user.attributes.merge(username: 'new_username')
        User.find(user.id).username.should == 'new_username'
      end
    end

    context 'when editing password' do
      let!(:user) do
        User.create(name: 'foo', username: 'foo', password: 'foo', password_confirmation: 'foo', year: 2013, repeated_year: 0)
      end

      before do
        controller.instance_variable_set(:@current_user, user)
      end

      it 'updates passowrd' do
        patch :update, item: 'password', user: user.attributes.merge(password: 'hoge', password_confirmation: 'hoge')
        BCrypt::Password.new(User.find(user.id).password_digest).should == 'hoge'
      end
    end
  end
end
