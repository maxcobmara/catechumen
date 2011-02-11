require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance" do
    assert_difference('Attendance.count') do
      post :create, :attendance => { }
    end

    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should show attendance" do
    get :show, :id => attendances(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => attendances(:one).to_param
    assert_response :success
  end

  test "should update attendance" do
    put :update, :id => attendances(:one).to_param, :attendance => { }
    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete :destroy, :id => attendances(:one).to_param
    end

    assert_redirected_to attendances_path
  end
end
