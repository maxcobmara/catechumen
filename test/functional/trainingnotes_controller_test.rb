require 'test_helper'

class TrainingnotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trainingnotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trainingnote" do
    assert_difference('Trainingnote.count') do
      post :create, :trainingnote => { }
    end

    assert_redirected_to trainingnote_path(assigns(:trainingnote))
  end

  test "should show trainingnote" do
    get :show, :id => trainingnotes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trainingnotes(:one).to_param
    assert_response :success
  end

  test "should update trainingnote" do
    put :update, :id => trainingnotes(:one).to_param, :trainingnote => { }
    assert_redirected_to trainingnote_path(assigns(:trainingnote))
  end

  test "should destroy trainingnote" do
    assert_difference('Trainingnote.count', -1) do
      delete :destroy, :id => trainingnotes(:one).to_param
    end

    assert_redirected_to trainingnotes_path
  end
end
