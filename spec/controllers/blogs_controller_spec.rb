require "spec_helper"

describe BlogsController do
  shared_examples_for "login required" do
    it "redirects to root_path" do
      subject
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("ログインが必要です")
    end
  end

  shared_examples_for "valid user required" do
    it "redirects to root_path" do
      subject
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("不正なユーザーです")
    end
  end

  describe "#index" do
  end

  describe "#show" do
  end

  describe "#new" do
    subject { get :new, user_id: user.username }
    let!(:user) { FactoryGirl.create(:user) }

    context "when user is not logged in" do
      it_behaves_like "login required"
    end

    context "when user is logged in with invalid user" do
      let!(:invalid_user) { FactoryGirl.create(:user, username: "invalid") }
      before { login_as(invalid_user) }

      it_behaves_like "valid user required"
    end

    context "when user is logged in with valid user" do
      before { login_as(user) }

      it "succeeds to render" do
        subject
        expect(response).to be_ok
        expect(assigns[:blog]).to be_a_kind_of(Blog)
        expect(assigns[:blog].user_id).to eq(user.id)
      end
    end
  end

  describe "#create" do
    subject do
      get :create, user_id: user.username, blog: { title: title, content: content, user_id: user.id }
    end

    let!(:user) { FactoryGirl.create(:user) }
    let(:title) { '今日の進捗' }
    let(:content) { '進捗どうですか？' }

    context "when user is not logged in" do
      it_behaves_like "login required"
    end

    context "when user is logged in with invalid user" do
      let!(:invalid_user) { FactoryGirl.create(:user, username: "invalid") }
      before { login_as(invalid_user) }

      it_behaves_like "valid user required"
    end

    context "when user is logged in with valid user" do
      before { login_as(user) }

      context "when hidden form's user_id is invalid" do
        let!(:invalid_user) { FactoryGirl.create(:user, username: "invalid") }

        subject do
          get :create, user_id: user.username, blog: { title: title, content: content, user_id: invalid_user.id }
        end

        it_behaves_like "valid user required"
      end

      context "when hidden form's user_id is valid" do
        let(:blog) { Blog.last }

        it "creates a blog" do
          expect {
            subject
          }.to change {
            Blog.count
          }.from(0).to(1)

          expect(blog.title).to eq(title)
          expect(blog.content).to eq(content)
          expect(blog.user_id).to eq(user.id)
          expect(response).to redirect_to(user_blog_path(user, blog))
        end
      end
    end
  end

  describe "#edit" do
  end

  describe "#update" do
  end

  describe "destroy" do
  end
end
