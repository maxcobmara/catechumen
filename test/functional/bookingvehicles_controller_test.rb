require 'test_helper'

class BookingvehiclesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookingvehicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookingvehicle" do
    assert_difference('Bookingvehicle.count') do
      post :create, :bookingvehicle => { }
    end

    assert_redirected_to bookingvehicle_path(assigns(:bookingvehicle))
  end

  test "should show bookingvehicle" do
    get :show, :id => bookingvehicles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bookingvehicles(:one).to_param
    assert_response :success
  end

  test "should update bookingvehicle" do
    put :update, :id => bookingvehicles(:one).to_param, :bookingvehicle => { }
    assert_redirected_to bookingvehicle_path(assigns(:bookingvehicle))
  end

  test "should destroy bookingvehicle" do
    assert_difference('Bookingvehicle.count', -1) do
      delete :destroy, :id => bookingvehicles(:one).to_param
    end

    assert_redirected_to bookingvehicles_path
  end
end
