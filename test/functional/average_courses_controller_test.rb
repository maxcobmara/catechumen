require 'test_helper'

class AverageCoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:average_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create average_course" do
    assert_difference('AverageCourse.count') do
      post :create, :average_course => { }
    end

    assert_redirected_to average_course_path(assigns(:average_course))
  end

  test "should show average_course" do
    get :show, :id => average_courses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => average_courses(:one).to_param
    assert_response :success
  end

  test "should update average_course" do
    put :update, :id => average_courses(:one).to_param, :average_course => { }
    assert_redirected_to average_course_path(assigns(:average_course))
  end

  test "should destroy average_course" do
    assert_difference('AverageCourse.count', -1) do
      delete :destroy, :id => average_courses(:one).to_param
    end

    assert_redirected_to average_courses_path
  end
end
