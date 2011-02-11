require 'test_helper'

class ExamquestionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examquestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examquestion" do
    assert_difference('Examquestion.count') do
      post :create, :examquestion => { }
    end

    assert_redirected_to examquestion_path(assigns(:examquestion))
  end

  test "should show examquestion" do
    get :show, :id => examquestions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examquestions(:one).to_param
    assert_response :success
  end

  test "should update examquestion" do
    put :update, :id => examquestions(:one).to_param, :examquestion => { }
    assert_redirected_to examquestion_path(assigns(:examquestion))
  end

  test "should destroy examquestion" do
    assert_difference('Examquestion.count', -1) do
      delete :destroy, :id => examquestions(:one).to_param
    end

    assert_redirected_to examquestions_path
  end
end
