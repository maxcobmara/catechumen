require 'test_helper'

class ShortessaysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shortessays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shortessay" do
    assert_difference('Shortessay.count') do
      post :create, :shortessay => { }
    end

    assert_redirected_to shortessay_path(assigns(:shortessay))
  end

  test "should show shortessay" do
    get :show, :id => shortessays(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => shortessays(:one).to_param
    assert_response :success
  end

  test "should update shortessay" do
    put :update, :id => shortessays(:one).to_param, :shortessay => { }
    assert_redirected_to shortessay_path(assigns(:shortessay))
  end

  test "should destroy shortessay" do
    assert_difference('Shortessay.count', -1) do
      delete :destroy, :id => shortessays(:one).to_param
    end

    assert_redirected_to shortessays_path
  end
end
