require 'test_helper'

class OfficecarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:officecars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create officecar" do
    assert_difference('Officecar.count') do
      post :create, :officecar => { }
    end

    assert_redirected_to officecar_path(assigns(:officecar))
  end

  test "should show officecar" do
    get :show, :id => officecars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => officecars(:one).to_param
    assert_response :success
  end

  test "should update officecar" do
    put :update, :id => officecars(:one).to_param, :officecar => { }
    assert_redirected_to officecar_path(assigns(:officecar))
  end

  test "should destroy officecar" do
    assert_difference('Officecar.count', -1) do
      delete :destroy, :id => officecars(:one).to_param
    end

    assert_redirected_to officecars_path
  end
end
