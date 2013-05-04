require 'test_helper'

class AnalysispaperexamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analysispaperexams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analysispaperexam" do
    assert_difference('Analysispaperexam.count') do
      post :create, :analysispaperexam => { }
    end

    assert_redirected_to analysispaperexam_path(assigns(:analysispaperexam))
  end

  test "should show analysispaperexam" do
    get :show, :id => analysispaperexams(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => analysispaperexams(:one).to_param
    assert_response :success
  end

  test "should update analysispaperexam" do
    put :update, :id => analysispaperexams(:one).to_param, :analysispaperexam => { }
    assert_redirected_to analysispaperexam_path(assigns(:analysispaperexam))
  end

  test "should destroy analysispaperexam" do
    assert_difference('Analysispaperexam.count', -1) do
      delete :destroy, :id => analysispaperexams(:one).to_param
    end

    assert_redirected_to analysispaperexams_path
  end
end
