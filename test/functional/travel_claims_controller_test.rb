require 'test_helper'

class TravelClaimsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_claims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_claim" do
    assert_difference('TravelClaim.count') do
      post :create, :travel_claim => { }
    end

    assert_redirected_to travel_claim_path(assigns(:travel_claim))
  end

  test "should show travel_claim" do
    get :show, :id => travel_claims(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travel_claims(:one).to_param
    assert_response :success
  end

  test "should update travel_claim" do
    put :update, :id => travel_claims(:one).to_param, :travel_claim => { }
    assert_redirected_to travel_claim_path(assigns(:travel_claim))
  end

  test "should destroy travel_claim" do
    assert_difference('TravelClaim.count', -1) do
      delete :destroy, :id => travel_claims(:one).to_param
    end

    assert_redirected_to travel_claims_path
  end
end
