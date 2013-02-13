require 'test_helper'

class ContestdatesControllerTest < ActionController::TestCase
  setup do
    @contestdate = contestdates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contestdates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contestdate" do
    assert_difference('Contestdate.count') do
      post :create, :contestdate => { :order => @contestdate.order, :place => @contestdate.place }
    end

    assert_redirected_to contestdate_path(assigns(:contestdate))
  end

  test "should show contestdate" do
    get :show, :id => @contestdate
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contestdate
    assert_response :success
  end

  test "should update contestdate" do
    put :update, :id => @contestdate, :contestdate => { :order => @contestdate.order, :place => @contestdate.place }
    assert_redirected_to contestdate_path(assigns(:contestdate))
  end

  test "should destroy contestdate" do
    assert_difference('Contestdate.count', -1) do
      delete :destroy, :id => @contestdate
    end

    assert_redirected_to contestdates_path
  end
end
