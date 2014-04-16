require 'spec_helper'

describe EntriesController do
  render_views
  fixtures :entries

  describe 'GET "frontpage"' do
    it 'should render #show' do
      get 'frontpage'
      response.should be_success
      response.should render_template('show')
    end
  end

  describe '#show' do
    it 'should render a specific entry' do
      get :frontpage
      response.should contain('frontpage is rendered')
    end

    it 'should be able to render entries which contain tabs' do
      get :show, id: 'tips'
      response.should be_success
    end
  end

  describe '#destroy' do
    let!(:entry) { Entry.make! }

    context 'when login user is admin' do
      before do
        controller.stub(:is_admin?).and_return(true)
      end

      it 'succeeds to destroy the entry' do
        expect {
          delete :destroy, id: entry.id
        }.to change {
          Entry.count
        }.by(-1)
      end
    end

    context 'when login user is not admin' do
      before do
        controller.stub(:is_admin?).and_return(false)
      end

      it 'fails to destroy the entry' do
        expect {
          delete :destroy, id: entry.id
        }.to raise_error
      end
    end
  end
end
