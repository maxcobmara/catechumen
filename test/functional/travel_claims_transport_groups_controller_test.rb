require 'test_helper'

class TravelClaimsTransportGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_claims_transport_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_claims_transport_group" do
    assert_difference('TravelClaimsTransportGroup.count') do
      post :create, :travel_claims_transport_group => { }
    end

    assert_redirected_to travel_claims_transport_group_path(assigns(:travel_claims_transport_group))
  end

  test "should show travel_claims_transport_group" do
    get :show, :id => travel_claims_transport_groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travel_claims_transport_groups(:one).to_param
    assert_response :success
  end

  test "should update travel_claims_transport_group" do
    put :update, :id => travel_claims_transport_groups(:one).to_param, :travel_claims_transport_group => { }
    assert_redirected_to travel_claims_transport_group_path(assigns(:travel_claims_transport_group))
  end

  test "should destroy travel_claims_transport_group" do
    assert_difference('TravelClaimsTransportGroup.count', -1) do
      delete :destroy, :id => travel_claims_transport_groups(:one).to_param
    end

    assert_redirected_to travel_claims_transport_groups_path
  end
end
