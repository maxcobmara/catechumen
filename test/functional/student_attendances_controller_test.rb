require 'test_helper'

class StudentAttendancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_attendance" do
    assert_difference('StudentAttendance.count') do
      post :create, :student_attendance => { }
    end

    assert_redirected_to student_attendance_path(assigns(:student_attendance))
  end

  test "should show student_attendance" do
    get :show, :id => student_attendances(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_attendances(:one).to_param
    assert_response :success
  end

  test "should update student_attendance" do
    put :update, :id => student_attendances(:one).to_param, :student_attendance => { }
    assert_redirected_to student_attendance_path(assigns(:student_attendance))
  end

  test "should destroy student_attendance" do
    assert_difference('StudentAttendance.count', -1) do
      delete :destroy, :id => student_attendances(:one).to_param
    end

    assert_redirected_to student_attendances_path
  end
end
