require 'test_helper'

class TrainingrequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trainingrequests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trainingrequest" do
    assert_difference('Trainingrequest.count') do
      post :create, :trainingrequest => { }
    end

    assert_redirected_to trainingrequest_path(assigns(:trainingrequest))
  end

  test "should show trainingrequest" do
    get :show, :id => trainingrequests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trainingrequests(:one).to_param
    assert_response :success
  end

  test "should update trainingrequest" do
    put :update, :id => trainingrequests(:one).to_param, :trainingrequest => { }
    assert_redirected_to trainingrequest_path(assigns(:trainingrequest))
  end

  test "should destroy trainingrequest" do
    assert_difference('Trainingrequest.count', -1) do
      delete :destroy, :id => trainingrequests(:one).to_param
    end

    assert_redirected_to trainingrequests_path
  end
end
