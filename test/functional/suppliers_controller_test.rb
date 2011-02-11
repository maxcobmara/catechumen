require 'test_helper'

class SuppliersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suppliers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier" do
    assert_difference('Supplier.count') do
      post :create, :supplier => { }
    end

    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should show supplier" do
    get :show, :id => suppliers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => suppliers(:one).to_param
    assert_response :success
  end

  test "should update supplier" do
    put :update, :id => suppliers(:one).to_param, :supplier => { }
    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should destroy supplier" do
    assert_difference('Supplier.count', -1) do
      delete :destroy, :id => suppliers(:one).to_param
    end

    assert_redirected_to suppliers_path
  end
end
