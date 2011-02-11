require 'test_helper'

class StaffgradesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffgrades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffgrade" do
    assert_difference('Staffgrade.count') do
      post :create, :staffgrade => { }
    end

    assert_redirected_to staffgrade_path(assigns(:staffgrade))
  end

  test "should show staffgrade" do
    get :show, :id => staffgrades(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffgrades(:one).to_param
    assert_response :success
  end

  test "should update staffgrade" do
    put :update, :id => staffgrades(:one).to_param, :staffgrade => { }
    assert_redirected_to staffgrade_path(assigns(:staffgrade))
  end

  test "should destroy staffgrade" do
    assert_difference('Staffgrade.count', -1) do
      delete :destroy, :id => staffgrades(:one).to_param
    end

    assert_redirected_to staffgrades_path
  end
end
