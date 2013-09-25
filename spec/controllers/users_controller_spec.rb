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
end
