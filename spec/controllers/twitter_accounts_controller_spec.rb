require "spec_helper"

describe TwitterAccountsController do
  describe "#destroy" do
    let!(:user) { FactoryGirl.create(:user) }

    before do
      controller.instance_variable_set(:@current_user, user)
    end

    context "when login user has a given twitter account" do
      let!(:twitter_account) { FactoryGirl.create(:twitter_account, user: user) }

      it "succeeds to destroy the twitter account" do
        expect {
          delete :destroy, id: twitter_account.id
        }.to change {
          TwitterAccount.count
        }.from(1).to(0)
      end
    end

    context "when login user does not have a given twitter account" do
      let!(:twitter_account) { FactoryGirl.create(:twitter_account) }

      it "fails to destroy the twitter account" do
        expect {
          delete :destroy, id: twitter_account.id
        }.to_not change {
          TwitterAccount.count
        }.from(1).to(0)
      end
    end
  end
end
