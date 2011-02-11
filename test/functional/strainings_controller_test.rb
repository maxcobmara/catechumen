require 'test_helper'

class StrainingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:strainings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create straining" do
    assert_difference('Straining.count') do
      post :create, :straining => { }
    end

    assert_redirected_to straining_path(assigns(:straining))
  end

  test "should show straining" do
    get :show, :id => strainings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => strainings(:one).to_param
    assert_response :success
  end

  test "should update straining" do
    put :update, :id => strainings(:one).to_param, :straining => { }
    assert_redirected_to straining_path(assigns(:straining))
  end

  test "should destroy straining" do
    assert_difference('Straining.count', -1) do
      delete :destroy, :id => strainings(:one).to_param
    end

    assert_redirected_to strainings_path
  end
end
