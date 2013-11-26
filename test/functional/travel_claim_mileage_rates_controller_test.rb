require 'test_helper'

class TravelClaimMileageRatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_claim_mileage_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_claim_mileage_rate" do
    assert_difference('TravelClaimMileageRate.count') do
      post :create, :travel_claim_mileage_rate => { }
    end

    assert_redirected_to travel_claim_mileage_rate_path(assigns(:travel_claim_mileage_rate))
  end

  test "should show travel_claim_mileage_rate" do
    get :show, :id => travel_claim_mileage_rates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travel_claim_mileage_rates(:one).to_param
    assert_response :success
  end

  test "should update travel_claim_mileage_rate" do
    put :update, :id => travel_claim_mileage_rates(:one).to_param, :travel_claim_mileage_rate => { }
    assert_redirected_to travel_claim_mileage_rate_path(assigns(:travel_claim_mileage_rate))
  end

  test "should destroy travel_claim_mileage_rate" do
    assert_difference('TravelClaimMileageRate.count', -1) do
      delete :destroy, :id => travel_claim_mileage_rates(:one).to_param
    end

    assert_redirected_to travel_claim_mileage_rates_path
  end
end
