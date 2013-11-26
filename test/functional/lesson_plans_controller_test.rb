require 'test_helper'

class LessonPlansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lesson_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson_plan" do
    assert_difference('LessonPlan.count') do
      post :create, :lesson_plan => { }
    end

    assert_redirected_to lesson_plan_path(assigns(:lesson_plan))
  end

  test "should show lesson_plan" do
    get :show, :id => lesson_plans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lesson_plans(:one).to_param
    assert_response :success
  end

  test "should update lesson_plan" do
    put :update, :id => lesson_plans(:one).to_param, :lesson_plan => { }
    assert_redirected_to lesson_plan_path(assigns(:lesson_plan))
  end

  test "should destroy lesson_plan" do
    assert_difference('LessonPlan.count', -1) do
      delete :destroy, :id => lesson_plans(:one).to_param
    end

    assert_redirected_to lesson_plans_path
  end
end
