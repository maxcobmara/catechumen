require 'test_helper'

class StaffcoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffcourses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffcourse" do
    assert_difference('Staffcourse.count') do
      post :create, :staffcourse => { }
    end

    assert_redirected_to staffcourse_path(assigns(:staffcourse))
  end

  test "should show staffcourse" do
    get :show, :id => staffcourses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffcourses(:one).to_param
    assert_response :success
  end

  test "should update staffcourse" do
    put :update, :id => staffcourses(:one).to_param, :staffcourse => { }
    assert_redirected_to staffcourse_path(assigns(:staffcourse))
  end

  test "should destroy staffcourse" do
    assert_difference('Staffcourse.count', -1) do
      delete :destroy, :id => staffcourses(:one).to_param
    end

    assert_redirected_to staffcourses_path
  end
end
