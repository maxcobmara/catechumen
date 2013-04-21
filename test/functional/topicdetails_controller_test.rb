require 'test_helper'

class TopicdetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topicdetails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topicdetail" do
    assert_difference('Topicdetail.count') do
      post :create, :topicdetail => { }
    end

    assert_redirected_to topicdetail_path(assigns(:topicdetail))
  end

  test "should show topicdetail" do
    get :show, :id => topicdetails(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => topicdetails(:one).to_param
    assert_response :success
  end

  test "should update topicdetail" do
    put :update, :id => topicdetails(:one).to_param, :topicdetail => { }
    assert_redirected_to topicdetail_path(assigns(:topicdetail))
  end

  test "should destroy topicdetail" do
    assert_difference('Topicdetail.count', -1) do
      delete :destroy, :id => topicdetails(:one).to_param
    end

    assert_redirected_to topicdetails_path
  end
end
