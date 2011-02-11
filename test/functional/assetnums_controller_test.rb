require 'test_helper'

class AssetnumsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assetnums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assetnum" do
    assert_difference('Assetnum.count') do
      post :create, :assetnum => { }
    end

    assert_redirected_to assetnum_path(assigns(:assetnum))
  end

  test "should show assetnum" do
    get :show, :id => assetnums(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assetnums(:one).to_param
    assert_response :success
  end

  test "should update assetnum" do
    put :update, :id => assetnums(:one).to_param, :assetnum => { }
    assert_redirected_to assetnum_path(assigns(:assetnum))
  end

  test "should destroy assetnum" do
    assert_difference('Assetnum.count', -1) do
      delete :destroy, :id => assetnums(:one).to_param
    end

    assert_redirected_to assetnums_path
  end
end
