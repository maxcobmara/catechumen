require 'test_helper'

class StaffAttendancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_attendance" do
    assert_difference('StaffAttendance.count') do
      post :create, :staff_attendance => { }
    end

    assert_redirected_to staff_attendance_path(assigns(:staff_attendance))
  end

  test "should show staff_attendance" do
    get :show, :id => staff_attendances(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staff_attendances(:one).to_param
    assert_response :success
  end

  test "should update staff_attendance" do
    put :update, :id => staff_attendances(:one).to_param, :staff_attendance => { }
    assert_redirected_to staff_attendance_path(assigns(:staff_attendance))
  end

  test "should destroy staff_attendance" do
    assert_difference('StaffAttendance.count', -1) do
      delete :destroy, :id => staff_attendances(:one).to_param
    end

    assert_redirected_to staff_attendances_path
  end
end
