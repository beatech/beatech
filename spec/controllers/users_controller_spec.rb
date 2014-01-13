require "spec_helper"

describe UsersController do
  render_views

  describe "#index" do
    it "renders template index" do
      get :index
      expect(response).to render_template("index")
    end

    context "when there is no user" do
      it "succeeds to render" do
        get :index
        expect(response).to be_ok
      end
    end

    context "when there is a user" do
      let!(:user) { User.make! }

      it "succeeds to render" do
        get :index
        expect(response).to be_ok
      end
    end
  end
end
