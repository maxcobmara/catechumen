require 'test_helper'

class ExamanswersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examanswers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examanswer" do
    assert_difference('Examanswer.count') do
      post :create, :examanswer => { }
    end

    assert_redirected_to examanswer_path(assigns(:examanswer))
  end

  test "should show examanswer" do
    get :show, :id => examanswers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examanswers(:one).to_param
    assert_response :success
  end

  test "should update examanswer" do
    put :update, :id => examanswers(:one).to_param, :examanswer => { }
    assert_redirected_to examanswer_path(assigns(:examanswer))
  end

  test "should destroy examanswer" do
    assert_difference('Examanswer.count', -1) do
      delete :destroy, :id => examanswers(:one).to_param
    end

    assert_redirected_to examanswers_path
  end
end
