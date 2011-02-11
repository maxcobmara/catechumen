require 'test_helper'

class TravelrequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travelrequests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travelrequest" do
    assert_difference('Travelrequest.count') do
      post :create, :travelrequest => { }
    end

    assert_redirected_to travelrequest_path(assigns(:travelrequest))
  end

  test "should show travelrequest" do
    get :show, :id => travelrequests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travelrequests(:one).to_param
    assert_response :success
  end

  test "should update travelrequest" do
    put :update, :id => travelrequests(:one).to_param, :travelrequest => { }
    assert_redirected_to travelrequest_path(assigns(:travelrequest))
  end

  test "should destroy travelrequest" do
    assert_difference('Travelrequest.count', -1) do
      delete :destroy, :id => travelrequests(:one).to_param
    end

    assert_redirected_to travelrequests_path
  end
end
