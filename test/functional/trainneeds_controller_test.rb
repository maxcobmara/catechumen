require 'test_helper'

class TrainneedsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trainneeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trainneed" do
    assert_difference('Trainneed.count') do
      post :create, :trainneed => { }
    end

    assert_redirected_to trainneed_path(assigns(:trainneed))
  end

  test "should show trainneed" do
    get :show, :id => trainneeds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trainneeds(:one).to_param
    assert_response :success
  end

  test "should update trainneed" do
    put :update, :id => trainneeds(:one).to_param, :trainneed => { }
    assert_redirected_to trainneed_path(assigns(:trainneed))
  end

  test "should destroy trainneed" do
    assert_difference('Trainneed.count', -1) do
      delete :destroy, :id => trainneeds(:one).to_param
    end

    assert_redirected_to trainneeds_path
  end
end
