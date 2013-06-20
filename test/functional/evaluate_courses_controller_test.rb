require 'test_helper'

class EvaluateCoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluate_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluate_course" do
    assert_difference('EvaluateCourse.count') do
      post :create, :evaluate_course => { }
    end

    assert_redirected_to evaluate_course_path(assigns(:evaluate_course))
  end

  test "should show evaluate_course" do
    get :show, :id => evaluate_courses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evaluate_courses(:one).to_param
    assert_response :success
  end

  test "should update evaluate_course" do
    put :update, :id => evaluate_courses(:one).to_param, :evaluate_course => { }
    assert_redirected_to evaluate_course_path(assigns(:evaluate_course))
  end

  test "should destroy evaluate_course" do
    assert_difference('EvaluateCourse.count', -1) do
      delete :destroy, :id => evaluate_courses(:one).to_param
    end

    assert_redirected_to evaluate_courses_path
  end
end
