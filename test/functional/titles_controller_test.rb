require 'test_helper'

class TitlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:titles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create title" do
    assert_difference('Title.count') do
      post :create, :title => { }
    end

    assert_redirected_to title_path(assigns(:title))
  end

  test "should show title" do
    get :show, :id => titles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => titles(:one).to_param
    assert_response :success
  end

  test "should update title" do
    put :update, :id => titles(:one).to_param, :title => { }
    assert_redirected_to title_path(assigns(:title))
  end

  test "should destroy title" do
    assert_difference('Title.count', -1) do
      delete :destroy, :id => titles(:one).to_param
    end

    assert_redirected_to titles_path
  end
end
