require 'test_helper'

class ResidencesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:residences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create residence" do
    assert_difference('Residence.count') do
      post :create, :residence => { }
    end

    assert_redirected_to residence_path(assigns(:residence))
  end

  test "should show residence" do
    get :show, :id => residences(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => residences(:one).to_param
    assert_response :success
  end

  test "should update residence" do
    put :update, :id => residences(:one).to_param, :residence => { }
    assert_redirected_to residence_path(assigns(:residence))
  end

  test "should destroy residence" do
    assert_difference('Residence.count', -1) do
      delete :destroy, :id => residences(:one).to_param
    end

    assert_redirected_to residences_path
  end
end
