require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, :student => { }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, :id => students(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => students(:one).to_param
    assert_response :success
  end

  test "should update student" do
    put :update, :id => students(:one).to_param, :student => { }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, :id => students(:one).to_param
    end

    assert_redirected_to students_path
  end
end
