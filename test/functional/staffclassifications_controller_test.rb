require 'test_helper'

class StaffclassificationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffclassifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffclassification" do
    assert_difference('Staffclassification.count') do
      post :create, :staffclassification => { }
    end

    assert_redirected_to staffclassification_path(assigns(:staffclassification))
  end

  test "should show staffclassification" do
    get :show, :id => staffclassifications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffclassifications(:one).to_param
    assert_response :success
  end

  test "should update staffclassification" do
    put :update, :id => staffclassifications(:one).to_param, :staffclassification => { }
    assert_redirected_to staffclassification_path(assigns(:staffclassification))
  end

  test "should destroy staffclassification" do
    assert_difference('Staffclassification.count', -1) do
      delete :destroy, :id => staffclassifications(:one).to_param
    end

    assert_redirected_to staffclassifications_path
  end
end
