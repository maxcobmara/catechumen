require 'test_helper'

class StaffserveschemesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffserveschemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffservescheme" do
    assert_difference('Staffservescheme.count') do
      post :create, :staffservescheme => { }
    end

    assert_redirected_to staffservescheme_path(assigns(:staffservescheme))
  end

  test "should show staffservescheme" do
    get :show, :id => staffserveschemes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffserveschemes(:one).to_param
    assert_response :success
  end

  test "should update staffservescheme" do
    put :update, :id => staffserveschemes(:one).to_param, :staffservescheme => { }
    assert_redirected_to staffservescheme_path(assigns(:staffservescheme))
  end

  test "should destroy staffservescheme" do
    assert_difference('Staffservescheme.count', -1) do
      delete :destroy, :id => staffserveschemes(:one).to_param
    end

    assert_redirected_to staffserveschemes_path
  end
end
