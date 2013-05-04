require 'test_helper'

class TravelclaimsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travelclaims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travelclaim" do
    assert_difference('Travelclaim.count') do
      post :create, :travelclaim => { }
    end

    assert_redirected_to travelclaim_path(assigns(:travelclaim))
  end

  test "should show travelclaim" do
    get :show, :id => travelclaims(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travelclaims(:one).to_param
    assert_response :success
  end

  test "should update travelclaim" do
    put :update, :id => travelclaims(:one).to_param, :travelclaim => { }
    assert_redirected_to travelclaim_path(assigns(:travelclaim))
  end

  test "should destroy travelclaim" do
    assert_difference('Travelclaim.count', -1) do
      delete :destroy, :id => travelclaims(:one).to_param
    end

    assert_redirected_to travelclaims_path
  end
end
