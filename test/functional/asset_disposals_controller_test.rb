require 'test_helper'

class AssetDisposalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_disposals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_disposal" do
    assert_difference('AssetDisposal.count') do
      post :create, :asset_disposal => { }
    end

    assert_redirected_to asset_disposal_path(assigns(:asset_disposal))
  end

  test "should show asset_disposal" do
    get :show, :id => asset_disposals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => asset_disposals(:one).to_param
    assert_response :success
  end

  test "should update asset_disposal" do
    put :update, :id => asset_disposals(:one).to_param, :asset_disposal => { }
    assert_redirected_to asset_disposal_path(assigns(:asset_disposal))
  end

  test "should destroy asset_disposal" do
    assert_difference('AssetDisposal.count', -1) do
      delete :destroy, :id => asset_disposals(:one).to_param
    end

    assert_redirected_to asset_disposals_path
  end
end
