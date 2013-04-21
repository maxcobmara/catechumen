require 'test_helper'

class StaffAppraisalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_appraisals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_appraisal" do
    assert_difference('StaffAppraisal.count') do
      post :create, :staff_appraisal => { }
    end

    assert_redirected_to staff_appraisal_path(assigns(:staff_appraisal))
  end

  test "should show staff_appraisal" do
    get :show, :id => staff_appraisals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staff_appraisals(:one).to_param
    assert_response :success
  end

  test "should update staff_appraisal" do
    put :update, :id => staff_appraisals(:one).to_param, :staff_appraisal => { }
    assert_redirected_to staff_appraisal_path(assigns(:staff_appraisal))
  end

  test "should destroy staff_appraisal" do
    assert_difference('StaffAppraisal.count', -1) do
      delete :destroy, :id => staff_appraisals(:one).to_param
    end

    assert_redirected_to staff_appraisals_path
  end
end
