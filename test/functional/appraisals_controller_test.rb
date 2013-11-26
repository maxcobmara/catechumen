require 'test_helper'

class AppraisalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appraisals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appraisal" do
    assert_difference('Appraisal.count') do
      post :create, :appraisal => { }
    end

    assert_redirected_to appraisal_path(assigns(:appraisal))
  end

  test "should show appraisal" do
    get :show, :id => appraisals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => appraisals(:one).to_param
    assert_response :success
  end

  test "should update appraisal" do
    put :update, :id => appraisals(:one).to_param, :appraisal => { }
    assert_redirected_to appraisal_path(assigns(:appraisal))
  end

  test "should destroy appraisal" do
    assert_difference('Appraisal.count', -1) do
      delete :destroy, :id => appraisals(:one).to_param
    end

    assert_redirected_to appraisals_path
  end
end
