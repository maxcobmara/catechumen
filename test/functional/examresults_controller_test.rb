require 'test_helper'

class ExamresultsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examresults)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examresult" do
    assert_difference('Examresult.count') do
      post :create, :examresult => { }
    end

    assert_redirected_to examresult_path(assigns(:examresult))
  end

  test "should show examresult" do
    get :show, :id => examresults(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examresults(:one).to_param
    assert_response :success
  end

  test "should update examresult" do
    put :update, :id => examresults(:one).to_param, :examresult => { }
    assert_redirected_to examresult_path(assigns(:examresult))
  end

  test "should destroy examresult" do
    assert_difference('Examresult.count', -1) do
      delete :destroy, :id => examresults(:one).to_param
    end

    assert_redirected_to examresults_path
  end
end
