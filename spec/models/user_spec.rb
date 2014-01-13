require "spec_helper"

describe User do
  describe ".year_by_grade" do
    context "" do
    end

    context "" do
    end
  end

  describe ".authenticate" do
    let!(:user) do
      User.make!(username: "username", password: "password", password_confirmation: "password")
    end

    context "given valid username" do
      let(:username) { "username" }

      context "given valid password" do
        let(:password) { "password" }

        it "returns user" do
          expect(User.authenticate(username, password)).to eq(user)
        end
      end

      context "given invalid password" do
        let(:password) { "pass" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end
    end

    context "given invalid username" do
      let(:username) { "user" }

      context "given valid password" do
        let(:password) { "password" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end

      context "given invalid password" do
        let(:password) { "pass" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end
    end
  end
end
