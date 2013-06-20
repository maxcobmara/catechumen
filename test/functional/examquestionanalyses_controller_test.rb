require 'test_helper'

class ExamquestionanalysesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examquestionanalyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examquestionanalysis" do
    assert_difference('Examquestionanalysis.count') do
      post :create, :examquestionanalysis => { }
    end

    assert_redirected_to examquestionanalysis_path(assigns(:examquestionanalysis))
  end

  test "should show examquestionanalysis" do
    get :show, :id => examquestionanalyses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examquestionanalyses(:one).to_param
    assert_response :success
  end

  test "should update examquestionanalysis" do
    put :update, :id => examquestionanalyses(:one).to_param, :examquestionanalysis => { }
    assert_redirected_to examquestionanalysis_path(assigns(:examquestionanalysis))
  end

  test "should destroy examquestionanalysis" do
    assert_difference('Examquestionanalysis.count', -1) do
      delete :destroy, :id => examquestionanalyses(:one).to_param
    end

    assert_redirected_to examquestionanalyses_path
  end
end
