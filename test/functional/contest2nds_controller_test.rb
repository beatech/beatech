require 'test_helper'

class Contest2ndsControllerTest < ActionController::TestCase
  setup do
    @contest2nd = contest2nds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contest2nds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contest2nd" do
    assert_difference('Contest2nd.count') do
      post :create, :contest2nd => { :a_bp => @contest2nd.a_bp, :a_score => @contest2nd.a_score, :b_bp => @contest2nd.b_bp, :b_score => @contest2nd.b_score, :c_bp => @contest2nd.c_bp, :c_score => @contest2nd.c_score, :music => @contest2nd.music, :name => @contest2nd.name, :notes => @contest2nd.notes, :order => @contest2nd.order, :team => @contest2nd.team }
    end

    assert_redirected_to contest2nd_path(assigns(:contest2nd))
  end

  test "should show contest2nd" do
    get :show, :id => @contest2nd
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contest2nd
    assert_response :success
  end

  test "should update contest2nd" do
    put :update, :id => @contest2nd, :contest2nd => { :a_bp => @contest2nd.a_bp, :a_score => @contest2nd.a_score, :b_bp => @contest2nd.b_bp, :b_score => @contest2nd.b_score, :c_bp => @contest2nd.c_bp, :c_score => @contest2nd.c_score, :music => @contest2nd.music, :name => @contest2nd.name, :notes => @contest2nd.notes, :order => @contest2nd.order, :team => @contest2nd.team }
    assert_redirected_to contest2nd_path(assigns(:contest2nd))
  end

  test "should destroy contest2nd" do
    assert_difference('Contest2nd.count', -1) do
      delete :destroy, :id => @contest2nd
    end

    assert_redirected_to contest2nds_path
  end
end
