require 'test_helper'

class PtbudgetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptbudgets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ptbudget" do
    assert_difference('Ptbudget.count') do
      post :create, :ptbudget => { }
    end

    assert_redirected_to ptbudget_path(assigns(:ptbudget))
  end

  test "should show ptbudget" do
    get :show, :id => ptbudgets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ptbudgets(:one).to_param
    assert_response :success
  end

  test "should update ptbudget" do
    put :update, :id => ptbudgets(:one).to_param, :ptbudget => { }
    assert_redirected_to ptbudget_path(assigns(:ptbudget))
  end

  test "should destroy ptbudget" do
    assert_difference('Ptbudget.count', -1) do
      delete :destroy, :id => ptbudgets(:one).to_param
    end

    assert_redirected_to ptbudgets_path
  end
end
