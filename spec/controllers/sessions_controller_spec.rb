require 'spec_helper'

describe SessionsController do
  describe '#create' do
    let!(:user) { User.make! }
    let(:referer) { 'http://beatech.net/' }
    before { request.env["HTTP_REFERER"] = referer }

    context 'given valid username and password' do
      let(:valid_username) { 'username' }
      let(:valid_password) { 'password' }
      before { User.stub(:authenticate).with(valid_username, valid_password).and_return(user) }

      it 'stores user id in session' do
        post :create, username: valid_username, password: valid_password, auto_login: '1'
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to back' do
        post :create, username: valid_username, password: valid_password, auto_login: '1'
        expect(response).to redirect_to(referer)
      end
    end

    context 'given invalid username and password' do
      let(:invalid_username) { 'user' }
      let(:invalid_password) { 'pass' }
      before { User.stub(:authenticate).with(invalid_username, invalid_password).and_return(nil) }

      it 'does not store user id in session' do
        post :create, username: invalid_username, password: invalid_password, auto_login: '1'
        expect(session[:user_id]).to eq(nil)
      end

      it 'redirects to back' do
        post :create, username: invalid_username, password: invalid_password, auto_login: '1'
        expect(response).to redirect_to(referer)
      end

      it 'shows a flash message that indicates the login failure' do
        post :create, username: invalid_username, password: invalid_password, auto_login: '1'
        expect(flash[:notice]).to eq('ログインに失敗しました。')
      end
    end
  end
end
