require 'test_helper'

class EvaluateLecturersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluate_lecturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluate_lecturer" do
    assert_difference('EvaluateLecturer.count') do
      post :create, :evaluate_lecturer => { }
    end

    assert_redirected_to evaluate_lecturer_path(assigns(:evaluate_lecturer))
  end

  test "should show evaluate_lecturer" do
    get :show, :id => evaluate_lecturers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evaluate_lecturers(:one).to_param
    assert_response :success
  end

  test "should update evaluate_lecturer" do
    put :update, :id => evaluate_lecturers(:one).to_param, :evaluate_lecturer => { }
    assert_redirected_to evaluate_lecturer_path(assigns(:evaluate_lecturer))
  end

  test "should destroy evaluate_lecturer" do
    assert_difference('EvaluateLecturer.count', -1) do
      delete :destroy, :id => evaluate_lecturers(:one).to_param
    end

    assert_redirected_to evaluate_lecturers_path
  end
end
