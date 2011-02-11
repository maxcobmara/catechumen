require 'test_helper'

class LeavesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leaves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leave" do
    assert_difference('Leave.count') do
      post :create, :leave => { }
    end

    assert_redirected_to leave_path(assigns(:leave))
  end

  test "should show leave" do
    get :show, :id => leaves(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => leaves(:one).to_param
    assert_response :success
  end

  test "should update leave" do
    put :update, :id => leaves(:one).to_param, :leave => { }
    assert_redirected_to leave_path(assigns(:leave))
  end

  test "should destroy leave" do
    assert_difference('Leave.count', -1) do
      delete :destroy, :id => leaves(:one).to_param
    end

    assert_redirected_to leaves_path
  end
end
