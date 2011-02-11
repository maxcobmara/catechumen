require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      post :create, :topic => { }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, :id => topics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => topics(:one).to_param
    assert_response :success
  end

  test "should update topic" do
    put :update, :id => topics(:one).to_param, :topic => { }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, :id => topics(:one).to_param
    end

    assert_redirected_to topics_path
  end
end
