require 'test_helper'

class LoansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post :create, :loan => { }
    end

    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should show loan" do
    get :show, :id => loans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => loans(:one).to_param
    assert_response :success
  end

  test "should update loan" do
    put :update, :id => loans(:one).to_param, :loan => { }
    assert_redirected_to loan_path(assigns(:loan))
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete :destroy, :id => loans(:one).to_param
    end

    assert_redirected_to loans_path
  end
end
