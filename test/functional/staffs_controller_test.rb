require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, :staff => { }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, :id => staffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffs(:one).to_param
    assert_response :success
  end

  test "should update staff" do
    put :update, :id => staffs(:one).to_param, :staff => { }
    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should destroy staff" do
    assert_difference('Staff.count', -1) do
      delete :destroy, :id => staffs(:one).to_param
    end

    assert_redirected_to staffs_path
  end
end
