require "spec_helper"

describe BlogsController, type: :controller do
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
    let!(:blog) { FactoryGirl.create(:blog) }

    it "succeeds to render" do
      get :index, user_id: blog.user.username
      expect(response).to be_ok
      expect(assigns[:blogs]).to eq([blog])
    end
  end

  describe "#show" do
    let!(:blog) { FactoryGirl.create(:blog) }

    it "succeeds to render" do
      get :show, user_id: blog.user.username, id: blog.id
      expect(response).to be_ok
      expect(assigns[:blog]).to eq(blog)
    end
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
      post :create, user_id: user.username, blog: { title: title, content: content, user_id: user.id }
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
          post :create, user_id: user.username, blog: { title: title, content: content, user_id: invalid_user.id }
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
    subject { get :edit, user_id: blog.user.username, id: blog.id }
    let!(:blog) { FactoryGirl.create(:blog) }

    context "when user is not logged in" do
      it_behaves_like "login required"
    end

    context "when user is logged in with invalid user" do
      let!(:invalid_user) { FactoryGirl.create(:user, username: "invalid") }
      before { login_as(invalid_user) }

      it_behaves_like "valid user required"
    end

    context "when user is logged in with valid user" do
      before { login_as(blog.user) }

      it "succeeds to render" do
        subject
        expect(response).to be_ok
        expect(assigns[:blog]).to eq(blog)
      end
    end
  end

  describe "#update" do
    subject do
      patch :update, user_id: user.username, id: blog.id,
        blog: { title: new_title, content: new_content, user_id: user.id }
    end

    let!(:user) { FactoryGirl.create(:user) }
    let!(:blog) { FactoryGirl.create(:blog, title: old_title, content: old_content, user_id: user.id) }
    let(:old_title) { '今日の進捗' }
    let(:new_title) { '明日の進捗' }
    let(:old_content) { '進捗どうですか？' }
    let(:new_content) { '進捗してますか？' }

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
          patch :update, user_id: user.username, id: blog.id,
            blog: { title: new_title, content: new_content, user_id: invalid_user.id }
        end

        it_behaves_like "valid user required"
      end

      context "when hidden form's user_id is valid" do
        it "updates a blog" do
          subject
          blog.reload
          expect(blog.title).to eq(new_title)
          expect(blog.content).to eq(new_content)
          expect(blog.user_id).to eq(user.id)
          expect(response).to redirect_to(user_blog_path(user, blog))
        end
      end
    end
  end

  describe "destroy" do
    subject do
      delete :destroy, user_id: user.username, id: blog.id
    end

    let!(:user) { FactoryGirl.create(:user) }
    let!(:blog) { FactoryGirl.create(:blog, user_id: user.id) }

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

      it "deletes a blog" do
        expect {
          subject
        }.to change {
          Blog.count
        }.from(1).to(0)

        expect(response).to redirect_to(user_blogs_path(user))
      end
    end
  end
end
