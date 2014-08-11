require "spec_helper"

describe BlogsController do
  describe "#index" do
  end

  describe "#show" do
  end

  describe "#new" do
    context "when user is not logged in" do
      let!(:user) { FactoryGirl.create(:user) }

      it "redirects to root_path" do
        get :new, user_id: user.username
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("ログインが必要です")
      end
    end

    context "when user is logged in with invalid user" do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:invalid_user) { FactoryGirl.create(:user, username: "invalid") }

      before { login_as(invalid_user) }

      it "redirects to root_path" do
        get :new, user_id: user.username
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("不正なユーザーです")
      end
    end

    context "when user is logged in with valid user" do
      let!(:user) { FactoryGirl.create(:user) }

      before { login_as(user) }

      it "succeeds to render" do
        get :new, user_id: user.username
        expect(response).to be_ok
        expect(assigns[:blog]).to be_a_kind_of(Blog)
        expect(assigns[:blog].user_id).to eq(user.id)
      end
    end
  end

  describe "#create" do
  end

  describe "#edit" do
  end

  describe "#update" do
  end

  describe "destroy" do
  end
end
