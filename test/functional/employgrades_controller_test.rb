require 'test_helper'

class EmploygradesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employgrades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employgrade" do
    assert_difference('Employgrade.count') do
      post :create, :employgrade => { }
    end

    assert_redirected_to employgrade_path(assigns(:employgrade))
  end

  test "should show employgrade" do
    get :show, :id => employgrades(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => employgrades(:one).to_param
    assert_response :success
  end

  test "should update employgrade" do
    put :update, :id => employgrades(:one).to_param, :employgrade => { }
    assert_redirected_to employgrade_path(assigns(:employgrade))
  end

  test "should destroy employgrade" do
    assert_difference('Employgrade.count', -1) do
      delete :destroy, :id => employgrades(:one).to_param
    end

    assert_redirected_to employgrades_path
  end
end
