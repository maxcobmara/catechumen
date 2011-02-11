require 'test_helper'

class CourseevaluationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courseevaluations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create courseevaluation" do
    assert_difference('Courseevaluation.count') do
      post :create, :courseevaluation => { }
    end

    assert_redirected_to courseevaluation_path(assigns(:courseevaluation))
  end

  test "should show courseevaluation" do
    get :show, :id => courseevaluations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => courseevaluations(:one).to_param
    assert_response :success
  end

  test "should update courseevaluation" do
    put :update, :id => courseevaluations(:one).to_param, :courseevaluation => { }
    assert_redirected_to courseevaluation_path(assigns(:courseevaluation))
  end

  test "should destroy courseevaluation" do
    assert_difference('Courseevaluation.count', -1) do
      delete :destroy, :id => courseevaluations(:one).to_param
    end

    assert_redirected_to courseevaluations_path
  end
end
