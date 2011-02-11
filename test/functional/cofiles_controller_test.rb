require 'test_helper'

class CofilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cofiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cofile" do
    assert_difference('Cofile.count') do
      post :create, :cofile => { }
    end

    assert_redirected_to cofile_path(assigns(:cofile))
  end

  test "should show cofile" do
    get :show, :id => cofiles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cofiles(:one).to_param
    assert_response :success
  end

  test "should update cofile" do
    put :update, :id => cofiles(:one).to_param, :cofile => { }
    assert_redirected_to cofile_path(assigns(:cofile))
  end

  test "should destroy cofile" do
    assert_difference('Cofile.count', -1) do
      delete :destroy, :id => cofiles(:one).to_param
    end

    assert_redirected_to cofiles_path
  end
end
