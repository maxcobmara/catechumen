require 'test_helper'

class ExammarksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exammarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exammark" do
    assert_difference('Exammark.count') do
      post :create, :exammark => { }
    end

    assert_redirected_to exammark_path(assigns(:exammark))
  end

  test "should show exammark" do
    get :show, :id => exammarks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => exammarks(:one).to_param
    assert_response :success
  end

  test "should update exammark" do
    put :update, :id => exammarks(:one).to_param, :exammark => { }
    assert_redirected_to exammark_path(assigns(:exammark))
  end

  test "should destroy exammark" do
    assert_difference('Exammark.count', -1) do
      delete :destroy, :id => exammarks(:one).to_param
    end

    assert_redirected_to exammarks_path
  end
end
