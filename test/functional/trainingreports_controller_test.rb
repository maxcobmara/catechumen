require 'test_helper'

class TrainingreportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trainingreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trainingreport" do
    assert_difference('Trainingreport.count') do
      post :create, :trainingreport => { }
    end

    assert_redirected_to trainingreport_path(assigns(:trainingreport))
  end

  test "should show trainingreport" do
    get :show, :id => trainingreports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trainingreports(:one).to_param
    assert_response :success
  end

  test "should update trainingreport" do
    put :update, :id => trainingreports(:one).to_param, :trainingreport => { }
    assert_redirected_to trainingreport_path(assigns(:trainingreport))
  end

  test "should destroy trainingreport" do
    assert_difference('Trainingreport.count', -1) do
      delete :destroy, :id => trainingreports(:one).to_param
    end

    assert_redirected_to trainingreports_path
  end
end
