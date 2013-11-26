require 'test_helper'

class AssetDefectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_defects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_defect" do
    assert_difference('AssetDefect.count') do
      post :create, :asset_defect => { }
    end

    assert_redirected_to asset_defect_path(assigns(:asset_defect))
  end

  test "should show asset_defect" do
    get :show, :id => asset_defects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => asset_defects(:one).to_param
    assert_response :success
  end

  test "should update asset_defect" do
    put :update, :id => asset_defects(:one).to_param, :asset_defect => { }
    assert_redirected_to asset_defect_path(assigns(:asset_defect))
  end

  test "should destroy asset_defect" do
    assert_difference('AssetDefect.count', -1) do
      delete :destroy, :id => asset_defects(:one).to_param
    end

    assert_redirected_to asset_defects_path
  end
end
