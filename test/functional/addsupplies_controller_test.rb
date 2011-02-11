require 'test_helper'

class AddsuppliesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addsupplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create addsupply" do
    assert_difference('Addsupply.count') do
      post :create, :addsupply => { }
    end

    assert_redirected_to addsupply_path(assigns(:addsupply))
  end

  test "should show addsupply" do
    get :show, :id => addsupplies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => addsupplies(:one).to_param
    assert_response :success
  end

  test "should update addsupply" do
    put :update, :id => addsupplies(:one).to_param, :addsupply => { }
    assert_redirected_to addsupply_path(assigns(:addsupply))
  end

  test "should destroy addsupply" do
    assert_difference('Addsupply.count', -1) do
      delete :destroy, :id => addsupplies(:one).to_param
    end

    assert_redirected_to addsupplies_path
  end
end
