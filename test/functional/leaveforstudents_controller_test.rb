require 'test_helper'

class LeaveforstudentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leaveforstudents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leaveforstudent" do
    assert_difference('Leaveforstudent.count') do
      post :create, :leaveforstudent => { }
    end

    assert_redirected_to leaveforstudent_path(assigns(:leaveforstudent))
  end

  test "should show leaveforstudent" do
    get :show, :id => leaveforstudents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => leaveforstudents(:one).to_param
    assert_response :success
  end

  test "should update leaveforstudent" do
    put :update, :id => leaveforstudents(:one).to_param, :leaveforstudent => { }
    assert_redirected_to leaveforstudent_path(assigns(:leaveforstudent))
  end

  test "should destroy leaveforstudent" do
    assert_difference('Leaveforstudent.count', -1) do
      delete :destroy, :id => leaveforstudents(:one).to_param
    end

    assert_redirected_to leaveforstudents_path
  end
end
