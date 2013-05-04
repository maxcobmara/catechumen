require 'test_helper'

class InstructorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instructors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instructor" do
    assert_difference('Instructor.count') do
      post :create, :instructor => { }
    end

    assert_redirected_to instructor_path(assigns(:instructor))
  end

  test "should show instructor" do
    get :show, :id => instructors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => instructors(:one).to_param
    assert_response :success
  end

  test "should update instructor" do
    put :update, :id => instructors(:one).to_param, :instructor => { }
    assert_redirected_to instructor_path(assigns(:instructor))
  end

  test "should destroy instructor" do
    assert_difference('Instructor.count', -1) do
      delete :destroy, :id => instructors(:one).to_param
    end

    assert_redirected_to instructors_path
  end
end
