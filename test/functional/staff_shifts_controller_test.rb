require 'test_helper'

class StaffShiftsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_shifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_shift" do
    assert_difference('StaffShift.count') do
      post :create, :staff_shift => { }
    end

    assert_redirected_to staff_shift_path(assigns(:staff_shift))
  end

  test "should show staff_shift" do
    get :show, :id => staff_shifts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staff_shifts(:one).to_param
    assert_response :success
  end

  test "should update staff_shift" do
    put :update, :id => staff_shifts(:one).to_param, :staff_shift => { }
    assert_redirected_to staff_shift_path(assigns(:staff_shift))
  end

  test "should destroy staff_shift" do
    assert_difference('StaffShift.count', -1) do
      delete :destroy, :id => staff_shifts(:one).to_param
    end

    assert_redirected_to staff_shifts_path
  end
end
