require 'spec_helper'

describe EntriesController do
  render_views
  fixtures :entries
  
  describe "GET 'frontpage'" do
    it "should render #show" do
      get 'frontpage'
      response.should be_success
      response.should render_template("show")
    end
  end

  describe "#show" do
    it "should render a specific entry" do
      get :frontpage
      response.should contain("frontpage is rendered")
    end

    it "should be able to render entries which contain tabs" do
      get :show, id: 'tips'
      response.should be_success
    end
  end
end