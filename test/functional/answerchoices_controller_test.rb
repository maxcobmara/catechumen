require 'test_helper'

class AnswerchoicesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answerchoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answerchoice" do
    assert_difference('Answerchoice.count') do
      post :create, :answerchoice => { }
    end

    assert_redirected_to answerchoice_path(assigns(:answerchoice))
  end

  test "should show answerchoice" do
    get :show, :id => answerchoices(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => answerchoices(:one).to_param
    assert_response :success
  end

  test "should update answerchoice" do
    put :update, :id => answerchoices(:one).to_param, :answerchoice => { }
    assert_redirected_to answerchoice_path(assigns(:answerchoice))
  end

  test "should destroy answerchoice" do
    assert_difference('Answerchoice.count', -1) do
      delete :destroy, :id => answerchoices(:one).to_param
    end

    assert_redirected_to answerchoices_path
  end
end
