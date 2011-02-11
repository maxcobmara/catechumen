require 'test_helper'

class LeaveforstaffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leaveforstaffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create leaveforstaff" do
    assert_difference('Leaveforstaff.count') do
      post :create, :leaveforstaff => { }
    end

    assert_redirected_to leaveforstaff_path(assigns(:leaveforstaff))
  end

  test "should show leaveforstaff" do
    get :show, :id => leaveforstaffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => leaveforstaffs(:one).to_param
    assert_response :success
  end

  test "should update leaveforstaff" do
    put :update, :id => leaveforstaffs(:one).to_param, :leaveforstaff => { }
    assert_redirected_to leaveforstaff_path(assigns(:leaveforstaff))
  end

  test "should destroy leaveforstaff" do
    assert_difference('Leaveforstaff.count', -1) do
      delete :destroy, :id => leaveforstaffs(:one).to_param
    end

    assert_redirected_to leaveforstaffs_path
  end
end
