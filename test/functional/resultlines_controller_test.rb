require 'test_helper'

class ResultlinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resultlines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resultline" do
    assert_difference('Resultline.count') do
      post :create, :resultline => { }
    end

    assert_redirected_to resultline_path(assigns(:resultline))
  end

  test "should show resultline" do
    get :show, :id => resultlines(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => resultlines(:one).to_param
    assert_response :success
  end

  test "should update resultline" do
    put :update, :id => resultlines(:one).to_param, :resultline => { }
    assert_redirected_to resultline_path(assigns(:resultline))
  end

  test "should destroy resultline" do
    assert_difference('Resultline.count', -1) do
      delete :destroy, :id => resultlines(:one).to_param
    end

    assert_redirected_to resultlines_path
  end
end
