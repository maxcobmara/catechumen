require 'test_helper'

class EvaluateCoachesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluate_coaches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluate_coach" do
    assert_difference('EvaluateCoach.count') do
      post :create, :evaluate_coach => { }
    end

    assert_redirected_to evaluate_coach_path(assigns(:evaluate_coach))
  end

  test "should show evaluate_coach" do
    get :show, :id => evaluate_coaches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evaluate_coaches(:one).to_param
    assert_response :success
  end

  test "should update evaluate_coach" do
    put :update, :id => evaluate_coaches(:one).to_param, :evaluate_coach => { }
    assert_redirected_to evaluate_coach_path(assigns(:evaluate_coach))
  end

  test "should destroy evaluate_coach" do
    assert_difference('EvaluateCoach.count', -1) do
      delete :destroy, :id => evaluate_coaches(:one).to_param
    end

    assert_redirected_to evaluate_coaches_path
  end
end
