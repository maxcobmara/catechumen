require 'test_helper'

class LibrarytransactionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:librarytransactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create librarytransaction" do
    assert_difference('Librarytransaction.count') do
      post :create, :librarytransaction => { }
    end

    assert_redirected_to librarytransaction_path(assigns(:librarytransaction))
  end

  test "should show librarytransaction" do
    get :show, :id => librarytransactions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => librarytransactions(:one).to_param
    assert_response :success
  end

  test "should update librarytransaction" do
    put :update, :id => librarytransactions(:one).to_param, :librarytransaction => { }
    assert_redirected_to librarytransaction_path(assigns(:librarytransaction))
  end

  test "should destroy librarytransaction" do
    assert_difference('Librarytransaction.count', -1) do
      delete :destroy, :id => librarytransactions(:one).to_param
    end

    assert_redirected_to librarytransactions_path
  end
end
