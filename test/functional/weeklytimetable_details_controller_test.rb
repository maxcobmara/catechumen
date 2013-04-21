require 'test_helper'

class WeeklytimetableDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklytimetable_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weeklytimetable_detail" do
    assert_difference('WeeklytimetableDetail.count') do
      post :create, :weeklytimetable_detail => { }
    end

    assert_redirected_to weeklytimetable_detail_path(assigns(:weeklytimetable_detail))
  end

  test "should show weeklytimetable_detail" do
    get :show, :id => weeklytimetable_details(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weeklytimetable_details(:one).to_param
    assert_response :success
  end

  test "should update weeklytimetable_detail" do
    put :update, :id => weeklytimetable_details(:one).to_param, :weeklytimetable_detail => { }
    assert_redirected_to weeklytimetable_detail_path(assigns(:weeklytimetable_detail))
  end

  test "should destroy weeklytimetable_detail" do
    assert_difference('WeeklytimetableDetail.count', -1) do
      delete :destroy, :id => weeklytimetable_details(:one).to_param
    end

    assert_redirected_to weeklytimetable_details_path
  end
end
