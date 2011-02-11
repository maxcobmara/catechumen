require 'test_helper'

class MaintsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maint" do
    assert_difference('Maint.count') do
      post :create, :maint => { }
    end

    assert_redirected_to maint_path(assigns(:maint))
  end

  test "should show maint" do
    get :show, :id => maints(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => maints(:one).to_param
    assert_response :success
  end

  test "should update maint" do
    put :update, :id => maints(:one).to_param, :maint => { }
    assert_redirected_to maint_path(assigns(:maint))
  end

  test "should destroy maint" do
    assert_difference('Maint.count', -1) do
      delete :destroy, :id => maints(:one).to_param
    end

    assert_redirected_to maints_path
  end
end
