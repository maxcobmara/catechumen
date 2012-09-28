require 'test_helper'

class StudentDisciplineCasesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_discipline_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_discipline_case" do
    assert_difference('StudentDisciplineCase.count') do
      post :create, :student_discipline_case => { }
    end

    assert_redirected_to student_discipline_case_path(assigns(:student_discipline_case))
  end

  test "should show student_discipline_case" do
    get :show, :id => student_discipline_cases(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_discipline_cases(:one).to_param
    assert_response :success
  end

  test "should update student_discipline_case" do
    put :update, :id => student_discipline_cases(:one).to_param, :student_discipline_case => { }
    assert_redirected_to student_discipline_case_path(assigns(:student_discipline_case))
  end

  test "should destroy student_discipline_case" do
    assert_difference('StudentDisciplineCase.count', -1) do
      delete :destroy, :id => student_discipline_cases(:one).to_param
    end

    assert_redirected_to student_discipline_cases_path
  end
end
