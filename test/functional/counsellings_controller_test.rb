require 'test_helper'

class CounsellingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counsellings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create counselling" do
    assert_difference('Counselling.count') do
      post :create, :counselling => { }
    end

    assert_redirected_to counselling_path(assigns(:counselling))
  end

  test "should show counselling" do
    get :show, :id => counsellings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => counsellings(:one).to_param
    assert_response :success
  end

  test "should update counselling" do
    put :update, :id => counsellings(:one).to_param, :counselling => { }
    assert_redirected_to counselling_path(assigns(:counselling))
  end

  test "should destroy counselling" do
    assert_difference('Counselling.count', -1) do
      delete :destroy, :id => counsellings(:one).to_param
    end

    assert_redirected_to counsellings_path
  end
end
