require 'test_helper'

class PtdosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptdos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ptdo" do
    assert_difference('Ptdo.count') do
      post :create, :ptdo => { }
    end

    assert_redirected_to ptdo_path(assigns(:ptdo))
  end

  test "should show ptdo" do
    get :show, :id => ptdos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ptdos(:one).to_param
    assert_response :success
  end

  test "should update ptdo" do
    put :update, :id => ptdos(:one).to_param, :ptdo => { }
    assert_redirected_to ptdo_path(assigns(:ptdo))
  end

  test "should destroy ptdo" do
    assert_difference('Ptdo.count', -1) do
      delete :destroy, :id => ptdos(:one).to_param
    end

    assert_redirected_to ptdos_path
  end
end
