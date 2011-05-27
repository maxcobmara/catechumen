require 'test_helper'

class StaffServiceschemesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_serviceschemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_servicescheme" do
    assert_difference('StaffServicescheme.count') do
      post :create, :staff_servicescheme => { }
    end

    assert_redirected_to staff_servicescheme_path(assigns(:staff_servicescheme))
  end

  test "should show staff_servicescheme" do
    get :show, :id => staff_serviceschemes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staff_serviceschemes(:one).to_param
    assert_response :success
  end

  test "should update staff_servicescheme" do
    put :update, :id => staff_serviceschemes(:one).to_param, :staff_servicescheme => { }
    assert_redirected_to staff_servicescheme_path(assigns(:staff_servicescheme))
  end

  test "should destroy staff_servicescheme" do
    assert_difference('StaffServicescheme.count', -1) do
      delete :destroy, :id => staff_serviceschemes(:one).to_param
    end

    assert_redirected_to staff_serviceschemes_path
  end
end
