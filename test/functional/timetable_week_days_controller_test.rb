require 'test_helper'

class TimetableWeekDaysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:timetable_week_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create timetable_week_day" do
    assert_difference('TimetableWeekDay.count') do
      post :create, :timetable_week_day => { }
    end

    assert_redirected_to timetable_week_day_path(assigns(:timetable_week_day))
  end

  test "should show timetable_week_day" do
    get :show, :id => timetable_week_days(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => timetable_week_days(:one).to_param
    assert_response :success
  end

  test "should update timetable_week_day" do
    put :update, :id => timetable_week_days(:one).to_param, :timetable_week_day => { }
    assert_redirected_to timetable_week_day_path(assigns(:timetable_week_day))
  end

  test "should destroy timetable_week_day" do
    assert_difference('TimetableWeekDay.count', -1) do
      delete :destroy, :id => timetable_week_days(:one).to_param
    end

    assert_redirected_to timetable_week_days_path
  end
end
