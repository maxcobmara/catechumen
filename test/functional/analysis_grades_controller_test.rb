require 'test_helper'

class AnalysisGradesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysis_grades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analysis_grade" do
    assert_difference('AnalysisGrade.count') do
      post :create, :analysis_grade => { }
    end

    assert_redirected_to analysis_grade_path(assigns(:analysis_grade))
  end

  test "should show analysis_grade" do
    get :show, :id => analysis_grades(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => analysis_grades(:one).to_param
    assert_response :success
  end

  test "should update analysis_grade" do
    put :update, :id => analysis_grades(:one).to_param, :analysis_grade => { }
    assert_redirected_to analysis_grade_path(assigns(:analysis_grade))
  end

  test "should destroy analysis_grade" do
    assert_difference('AnalysisGrade.count', -1) do
      delete :destroy, :id => analysis_grades(:one).to_param
    end

    assert_redirected_to analysis_grades_path
  end
end
