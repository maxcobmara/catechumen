require 'test_helper'

class SuppliesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supply" do
    assert_difference('Supply.count') do
      post :create, :supply => { }
    end

    assert_redirected_to supply_path(assigns(:supply))
  end

  test "should show supply" do
    get :show, :id => supplies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => supplies(:one).to_param
    assert_response :success
  end

  test "should update supply" do
    put :update, :id => supplies(:one).to_param, :supply => { }
    assert_redirected_to supply_path(assigns(:supply))
  end

  test "should destroy supply" do
    assert_difference('Supply.count', -1) do
      delete :destroy, :id => supplies(:one).to_param
    end

    assert_redirected_to supplies_path
  end
end
