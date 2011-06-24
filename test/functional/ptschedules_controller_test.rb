require 'test_helper'

class PtschedulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptschedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ptschedule" do
    assert_difference('Ptschedule.count') do
      post :create, :ptschedule => { }
    end

    assert_redirected_to ptschedule_path(assigns(:ptschedule))
  end

  test "should show ptschedule" do
    get :show, :id => ptschedules(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ptschedules(:one).to_param
    assert_response :success
  end

  test "should update ptschedule" do
    put :update, :id => ptschedules(:one).to_param, :ptschedule => { }
    assert_redirected_to ptschedule_path(assigns(:ptschedule))
  end

  test "should destroy ptschedule" do
    assert_difference('Ptschedule.count', -1) do
      delete :destroy, :id => ptschedules(:one).to_param
    end

    assert_redirected_to ptschedules_path
  end
end
