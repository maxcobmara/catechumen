require 'test_helper'

class ExammakersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exammakers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exammaker" do
    assert_difference('Exammaker.count') do
      post :create, :exammaker => { }
    end

    assert_redirected_to exammaker_path(assigns(:exammaker))
  end

  test "should show exammaker" do
    get :show, :id => exammakers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => exammakers(:one).to_param
    assert_response :success
  end

  test "should update exammaker" do
    put :update, :id => exammakers(:one).to_param, :exammaker => { }
    assert_redirected_to exammaker_path(assigns(:exammaker))
  end

  test "should destroy exammaker" do
    assert_difference('Exammaker.count', -1) do
      delete :destroy, :id => exammakers(:one).to_param
    end

    assert_redirected_to exammakers_path
  end
end
