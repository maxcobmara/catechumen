require 'test_helper'

class AssettracksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assettracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assettrack" do
    assert_difference('Assettrack.count') do
      post :create, :assettrack => { }
    end

    assert_redirected_to assettrack_path(assigns(:assettrack))
  end

  test "should show assettrack" do
    get :show, :id => assettracks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assettracks(:one).to_param
    assert_response :success
  end

  test "should update assettrack" do
    put :update, :id => assettracks(:one).to_param, :assettrack => { }
    assert_redirected_to assettrack_path(assigns(:assettrack))
  end

  test "should destroy assettrack" do
    assert_difference('Assettrack.count', -1) do
      delete :destroy, :id => assettracks(:one).to_param
    end

    assert_redirected_to assettracks_path
  end
end
