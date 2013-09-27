require 'spec_helper'

describe 'users/password.html.haml' do
  let(:user) do
    User.new(name: 'foo', username: 'foo', password: 'bar', password_confirmation: 'foo', year: 2013, repeated_year: 0)
  end

  before do
    assign(:current_user, user)
  end

  subject { render }

  it 'has form whose action is /settings/password' do
    subject.should have_selector('form[action="/settings/password"]')
  end
end
