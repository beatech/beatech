require 'test_helper'

class IidXcontest2ndsControllerTest < ActionController::TestCase
  setup do
    @iid_xcontest2nd = iid_xcontest2nds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:iid_xcontest2nds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iid_xcontest2nd" do
    assert_difference('IidXcontest2nd.count') do
      post :create, :iid_xcontest2nd => { :a_bp => @iid_xcontest2nd.a_bp, :a_score => @iid_xcontest2nd.a_score, :b_bp => @iid_xcontest2nd.b_bp, :b_score => @iid_xcontest2nd.b_score, :c_bp => @iid_xcontest2nd.c_bp, :c_score => @iid_xcontest2nd.c_score, :music => @iid_xcontest2nd.music, :name => @iid_xcontest2nd.name, :notes => @iid_xcontest2nd.notes, :order => @iid_xcontest2nd.order, :team => @iid_xcontest2nd.team }
    end

    assert_redirected_to iid_xcontest2nd_path(assigns(:iid_xcontest2nd))
  end

  test "should show iid_xcontest2nd" do
    get :show, :id => @iid_xcontest2nd
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @iid_xcontest2nd
    assert_response :success
  end

  test "should update iid_xcontest2nd" do
    put :update, :id => @iid_xcontest2nd, :iid_xcontest2nd => { :a_bp => @iid_xcontest2nd.a_bp, :a_score => @iid_xcontest2nd.a_score, :b_bp => @iid_xcontest2nd.b_bp, :b_score => @iid_xcontest2nd.b_score, :c_bp => @iid_xcontest2nd.c_bp, :c_score => @iid_xcontest2nd.c_score, :music => @iid_xcontest2nd.music, :name => @iid_xcontest2nd.name, :notes => @iid_xcontest2nd.notes, :order => @iid_xcontest2nd.order, :team => @iid_xcontest2nd.team }
    assert_redirected_to iid_xcontest2nd_path(assigns(:iid_xcontest2nd))
  end

  test "should destroy iid_xcontest2nd" do
    assert_difference('IidXcontest2nd.count', -1) do
      delete :destroy, :id => @iid_xcontest2nd
    end

    assert_redirected_to iid_xcontest2nds_path
  end
end
