require 'test_helper'

class AssetlossesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assetlosses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assetloss" do
    assert_difference('Assetloss.count') do
      post :create, :assetloss => { }
    end

    assert_redirected_to assetloss_path(assigns(:assetloss))
  end

  test "should show assetloss" do
    get :show, :id => assetlosses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assetlosses(:one).to_param
    assert_response :success
  end

  test "should update assetloss" do
    put :update, :id => assetlosses(:one).to_param, :assetloss => { }
    assert_redirected_to assetloss_path(assigns(:assetloss))
  end

  test "should destroy assetloss" do
    assert_difference('Assetloss.count', -1) do
      delete :destroy, :id => assetlosses(:one).to_param
    end

    assert_redirected_to assetlosses_path
  end
end
