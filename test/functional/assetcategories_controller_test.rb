require 'test_helper'

class AssetcategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assetcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assetcategory" do
    assert_difference('Assetcategory.count') do
      post :create, :assetcategory => { }
    end

    assert_redirected_to assetcategory_path(assigns(:assetcategory))
  end

  test "should show assetcategory" do
    get :show, :id => assetcategories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assetcategories(:one).to_param
    assert_response :success
  end

  test "should update assetcategory" do
    put :update, :id => assetcategories(:one).to_param, :assetcategory => { }
    assert_redirected_to assetcategory_path(assigns(:assetcategory))
  end

  test "should destroy assetcategory" do
    assert_difference('Assetcategory.count', -1) do
      delete :destroy, :id => assetcategories(:one).to_param
    end

    assert_redirected_to assetcategories_path
  end
end
