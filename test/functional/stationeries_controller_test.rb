require 'test_helper'

class StationeriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stationeries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stationery" do
    assert_difference('Stationery.count') do
      post :create, :stationery => { }
    end

    assert_redirected_to stationery_path(assigns(:stationery))
  end

  test "should show stationery" do
    get :show, :id => stationeries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stationeries(:one).to_param
    assert_response :success
  end

  test "should update stationery" do
    put :update, :id => stationeries(:one).to_param, :stationery => { }
    assert_redirected_to stationery_path(assigns(:stationery))
  end

  test "should destroy stationery" do
    assert_difference('Stationery.count', -1) do
      delete :destroy, :id => stationeries(:one).to_param
    end

    assert_redirected_to stationeries_path
  end
end
