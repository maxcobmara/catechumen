require 'test_helper'

class StudentleavesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studentleaves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studentleave" do
    assert_difference('Studentleave.count') do
      post :create, :studentleave => { }
    end

    assert_redirected_to studentleave_path(assigns(:studentleave))
  end

  test "should show studentleave" do
    get :show, :id => studentleaves(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => studentleaves(:one).to_param
    assert_response :success
  end

  test "should update studentleave" do
    put :update, :id => studentleaves(:one).to_param, :studentleave => { }
    assert_redirected_to studentleave_path(assigns(:studentleave))
  end

  test "should destroy studentleave" do
    assert_difference('Studentleave.count', -1) do
      delete :destroy, :id => studentleaves(:one).to_param
    end

    assert_redirected_to studentleaves_path
  end
end
