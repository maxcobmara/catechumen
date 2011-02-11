require 'test_helper'

class DisposalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:disposals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create disposal" do
    assert_difference('Disposal.count') do
      post :create, :disposal => { }
    end

    assert_redirected_to disposal_path(assigns(:disposal))
  end

  test "should show disposal" do
    get :show, :id => disposals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => disposals(:one).to_param
    assert_response :success
  end

  test "should update disposal" do
    put :update, :id => disposals(:one).to_param, :disposal => { }
    assert_redirected_to disposal_path(assigns(:disposal))
  end

  test "should destroy disposal" do
    assert_difference('Disposal.count', -1) do
      delete :destroy, :id => disposals(:one).to_param
    end

    assert_redirected_to disposals_path
  end
end
