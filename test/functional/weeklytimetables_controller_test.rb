require 'test_helper'

class WeeklytimetablesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklytimetables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weeklytimetable" do
    assert_difference('Weeklytimetable.count') do
      post :create, :weeklytimetable => { }
    end

    assert_redirected_to weeklytimetable_path(assigns(:weeklytimetable))
  end

  test "should show weeklytimetable" do
    get :show, :id => weeklytimetables(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weeklytimetables(:one).to_param
    assert_response :success
  end

  test "should update weeklytimetable" do
    put :update, :id => weeklytimetables(:one).to_param, :weeklytimetable => { }
    assert_redirected_to weeklytimetable_path(assigns(:weeklytimetable))
  end

  test "should destroy weeklytimetable" do
    assert_difference('Weeklytimetable.count', -1) do
      delete :destroy, :id => weeklytimetables(:one).to_param
    end

    assert_redirected_to weeklytimetables_path
  end
end
