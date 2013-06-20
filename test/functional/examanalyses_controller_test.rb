require 'test_helper'

class ExamanalysesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examanalyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examanalysis" do
    assert_difference('Examanalysis.count') do
      post :create, :examanalysis => { }
    end

    assert_redirected_to examanalysis_path(assigns(:examanalysis))
  end

  test "should show examanalysis" do
    get :show, :id => examanalyses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examanalyses(:one).to_param
    assert_response :success
  end

  test "should update examanalysis" do
    put :update, :id => examanalyses(:one).to_param, :examanalysis => { }
    assert_redirected_to examanalysis_path(assigns(:examanalysis))
  end

  test "should destroy examanalysis" do
    assert_difference('Examanalysis.count', -1) do
      delete :destroy, :id => examanalyses(:one).to_param
    end

    assert_redirected_to examanalyses_path
  end
end
