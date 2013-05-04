require 'test_helper'

class BookingfacilitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookingfacilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookingfacility" do
    assert_difference('Bookingfacility.count') do
      post :create, :bookingfacility => { }
    end

    assert_redirected_to bookingfacility_path(assigns(:bookingfacility))
  end

  test "should show bookingfacility" do
    get :show, :id => bookingfacilities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bookingfacilities(:one).to_param
    assert_response :success
  end

  test "should update bookingfacility" do
    put :update, :id => bookingfacilities(:one).to_param, :bookingfacility => { }
    assert_redirected_to bookingfacility_path(assigns(:bookingfacility))
  end

  test "should destroy bookingfacility" do
    assert_difference('Bookingfacility.count', -1) do
      delete :destroy, :id => bookingfacilities(:one).to_param
    end

    assert_redirected_to bookingfacilities_path
  end
end
