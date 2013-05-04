require 'test_helper'

class WeeklyprogrammesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklyprogrammes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weeklyprogramme" do
    assert_difference('Weeklyprogramme.count') do
      post :create, :weeklyprogramme => { }
    end

    assert_redirected_to weeklyprogramme_path(assigns(:weeklyprogramme))
  end

  test "should show weeklyprogramme" do
    get :show, :id => weeklyprogrammes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => weeklyprogrammes(:one).to_param
    assert_response :success
  end

  test "should update weeklyprogramme" do
    put :update, :id => weeklyprogrammes(:one).to_param, :weeklyprogramme => { }
    assert_redirected_to weeklyprogramme_path(assigns(:weeklyprogramme))
  end

  test "should destroy weeklyprogramme" do
    assert_difference('Weeklyprogramme.count', -1) do
      delete :destroy, :id => weeklyprogrammes(:one).to_param
    end

    assert_redirected_to weeklyprogrammes_path
  end
end
