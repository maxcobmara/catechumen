require 'test_helper'

class AssetLoansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_loan" do
    assert_difference('AssetLoan.count') do
      post :create, :asset_loan => { }
    end

    assert_redirected_to asset_loan_path(assigns(:asset_loan))
  end

  test "should show asset_loan" do
    get :show, :id => asset_loans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => asset_loans(:one).to_param
    assert_response :success
  end

  test "should update asset_loan" do
    put :update, :id => asset_loans(:one).to_param, :asset_loan => { }
    assert_redirected_to asset_loan_path(assigns(:asset_loan))
  end

  test "should destroy asset_loan" do
    assert_difference('AssetLoan.count', -1) do
      delete :destroy, :id => asset_loans(:one).to_param
    end

    assert_redirected_to asset_loans_path
  end
end
