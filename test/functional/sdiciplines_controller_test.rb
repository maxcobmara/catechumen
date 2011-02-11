require 'test_helper'

class SdiciplinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sdiciplines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sdicipline" do
    assert_difference('Sdicipline.count') do
      post :create, :sdicipline => { }
    end

    assert_redirected_to sdicipline_path(assigns(:sdicipline))
  end

  test "should show sdicipline" do
    get :show, :id => sdiciplines(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sdiciplines(:one).to_param
    assert_response :success
  end

  test "should update sdicipline" do
    put :update, :id => sdiciplines(:one).to_param, :sdicipline => { }
    assert_redirected_to sdicipline_path(assigns(:sdicipline))
  end

  test "should destroy sdicipline" do
    assert_difference('Sdicipline.count', -1) do
      delete :destroy, :id => sdiciplines(:one).to_param
    end

    assert_redirected_to sdiciplines_path
  end
end
