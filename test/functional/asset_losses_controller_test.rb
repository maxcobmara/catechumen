require 'test_helper'

class AssetLossesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_losses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_loss" do
    assert_difference('AssetLoss.count') do
      post :create, :asset_loss => { }
    end

    assert_redirected_to asset_loss_path(assigns(:asset_loss))
  end

  test "should show asset_loss" do
    get :show, :id => asset_losses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => asset_losses(:one).to_param
    assert_response :success
  end

  test "should update asset_loss" do
    put :update, :id => asset_losses(:one).to_param, :asset_loss => { }
    assert_redirected_to asset_loss_path(assigns(:asset_loss))
  end

  test "should destroy asset_loss" do
    assert_difference('AssetLoss.count', -1) do
      delete :destroy, :id => asset_losses(:one).to_param
    end

    assert_redirected_to asset_losses_path
  end
end
