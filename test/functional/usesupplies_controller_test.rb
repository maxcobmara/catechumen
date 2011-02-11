require 'test_helper'

class UsesuppliesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usesupplies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usesupply" do
    assert_difference('Usesupply.count') do
      post :create, :usesupply => { }
    end

    assert_redirected_to usesupply_path(assigns(:usesupply))
  end

  test "should show usesupply" do
    get :show, :id => usesupplies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => usesupplies(:one).to_param
    assert_response :success
  end

  test "should update usesupply" do
    put :update, :id => usesupplies(:one).to_param, :usesupply => { }
    assert_redirected_to usesupply_path(assigns(:usesupply))
  end

  test "should destroy usesupply" do
    assert_difference('Usesupply.count', -1) do
      delete :destroy, :id => usesupplies(:one).to_param
    end

    assert_redirected_to usesupplies_path
  end
end
