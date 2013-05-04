require 'test_helper'

class IntakesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intakes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intake" do
    assert_difference('Intake.count') do
      post :create, :intake => { }
    end

    assert_redirected_to intake_path(assigns(:intake))
  end

  test "should show intake" do
    get :show, :id => intakes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => intakes(:one).to_param
    assert_response :success
  end

  test "should update intake" do
    put :update, :id => intakes(:one).to_param, :intake => { }
    assert_redirected_to intake_path(assigns(:intake))
  end

  test "should destroy intake" do
    assert_difference('Intake.count', -1) do
      delete :destroy, :id => intakes(:one).to_param
    end

    assert_redirected_to intakes_path
  end
end
