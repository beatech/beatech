require 'spec_helper'

describe EntriesController do
  describe '#show' do
    let!(:entry) { FactoryGirl.create(:entry) }

    it 'succeeds to show an entry' do
      get :show, id: entry.url
      expect(response).to be_ok
      expect(assigns[:entry]).to eq(entry)
    end
  end
end
