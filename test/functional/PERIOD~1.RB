require 'test_helper'

class PeriodTimingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:period_timings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create period_timing" do
    assert_difference('PeriodTiming.count') do
      post :create, :period_timing => { }
    end

    assert_redirected_to period_timing_path(assigns(:period_timing))
  end

  test "should show period_timing" do
    get :show, :id => period_timings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => period_timings(:one).to_param
    assert_response :success
  end

  test "should update period_timing" do
    put :update, :id => period_timings(:one).to_param, :period_timing => { }
    assert_redirected_to period_timing_path(assigns(:period_timing))
  end

  test "should destroy period_timing" do
    assert_difference('PeriodTiming.count', -1) do
      delete :destroy, :id => period_timings(:one).to_param
    end

    assert_redirected_to period_timings_path
  end
end
