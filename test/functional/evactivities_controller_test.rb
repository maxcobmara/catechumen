require 'test_helper'

class EvactivitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evactivities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evactivity" do
    assert_difference('Evactivity.count') do
      post :create, :evactivity => { }
    end

    assert_redirected_to evactivity_path(assigns(:evactivity))
  end

  test "should show evactivity" do
    get :show, :id => evactivities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evactivities(:one).to_param
    assert_response :success
  end

  test "should update evactivity" do
    put :update, :id => evactivities(:one).to_param, :evactivity => { }
    assert_redirected_to evactivity_path(assigns(:evactivity))
  end

  test "should destroy evactivity" do
    assert_difference('Evactivity.count', -1) do
      delete :destroy, :id => evactivities(:one).to_param
    end

    assert_redirected_to evactivities_path
  end
end
