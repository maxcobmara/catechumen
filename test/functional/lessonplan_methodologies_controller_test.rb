require 'test_helper'

class LessonplanMethodologiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lessonplan_methodologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lessonplan_methodology" do
    assert_difference('LessonplanMethodology.count') do
      post :create, :lessonplan_methodology => { }
    end

    assert_redirected_to lessonplan_methodology_path(assigns(:lessonplan_methodology))
  end

  test "should show lessonplan_methodology" do
    get :show, :id => lessonplan_methodologies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lessonplan_methodologies(:one).to_param
    assert_response :success
  end

  test "should update lessonplan_methodology" do
    put :update, :id => lessonplan_methodologies(:one).to_param, :lessonplan_methodology => { }
    assert_redirected_to lessonplan_methodology_path(assigns(:lessonplan_methodology))
  end

  test "should destroy lessonplan_methodology" do
    assert_difference('LessonplanMethodology.count', -1) do
      delete :destroy, :id => lessonplan_methodologies(:one).to_param
    end

    assert_redirected_to lessonplan_methodologies_path
  end
end
