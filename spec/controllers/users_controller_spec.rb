require 'spec_helper'

describe UsersController do
  describe '#index' do
    it 'renders template index' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
