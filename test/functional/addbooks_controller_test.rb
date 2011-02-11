require 'test_helper'

class AddbooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create addbook" do
    assert_difference('Addbook.count') do
      post :create, :addbook => { }
    end

    assert_redirected_to addbook_path(assigns(:addbook))
  end

  test "should show addbook" do
    get :show, :id => addbooks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => addbooks(:one).to_param
    assert_response :success
  end

  test "should update addbook" do
    put :update, :id => addbooks(:one).to_param, :addbook => { }
    assert_redirected_to addbook_path(assigns(:addbook))
  end

  test "should destroy addbook" do
    assert_difference('Addbook.count', -1) do
      delete :destroy, :id => addbooks(:one).to_param
    end

    assert_redirected_to addbooks_path
  end
end
