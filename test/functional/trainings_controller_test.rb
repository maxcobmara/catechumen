require 'test_helper'

class TrainingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trainings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training" do
    assert_difference('Training.count') do
      post :create, :training => { }
    end

    assert_redirected_to training_path(assigns(:training))
  end

  test "should show training" do
    get :show, :id => trainings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trainings(:one).to_param
    assert_response :success
  end

  test "should update training" do
    put :update, :id => trainings(:one).to_param, :training => { }
    assert_redirected_to training_path(assigns(:training))
  end

  test "should destroy training" do
    assert_difference('Training.count', -1) do
      delete :destroy, :id => trainings(:one).to_param
    end

    assert_redirected_to trainings_path
  end
end
