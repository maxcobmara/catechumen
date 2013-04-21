require 'test_helper'

class BanksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank" do
    assert_difference('Bank.count') do
      post :create, :bank => { }
    end

    assert_redirected_to bank_path(assigns(:bank))
  end

  test "should show bank" do
    get :show, :id => banks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => banks(:one).to_param
    assert_response :success
  end

  test "should update bank" do
    put :update, :id => banks(:one).to_param, :bank => { }
    assert_redirected_to bank_path(assigns(:bank))
  end

  test "should destroy bank" do
    assert_difference('Bank.count', -1) do
      delete :destroy, :id => banks(:one).to_param
    end

    assert_redirected_to banks_path
  end
end
