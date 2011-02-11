require 'test_helper'

class StudentLeavesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_leaves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_leave" do
    assert_difference('StudentLeave.count') do
      post :create, :student_leave => { }
    end

    assert_redirected_to student_leave_path(assigns(:student_leave))
  end

  test "should show student_leave" do
    get :show, :id => student_leaves(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_leaves(:one).to_param
    assert_response :success
  end

  test "should update student_leave" do
    put :update, :id => student_leaves(:one).to_param, :student_leave => { }
    assert_redirected_to student_leave_path(assigns(:student_leave))
  end

  test "should destroy student_leave" do
    assert_difference('StudentLeave.count', -1) do
      delete :destroy, :id => student_leaves(:one).to_param
    end

    assert_redirected_to student_leaves_path
  end
end
