require 'test_helper'

class ClassesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class" do
    assert_difference('Class.count') do
      post :create, :class => { }
    end

    assert_redirected_to class_path(assigns(:class))
  end

  test "should show class" do
    get :show, :id => classes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => classes(:one).to_param
    assert_response :success
  end

  test "should update class" do
    put :update, :id => classes(:one).to_param, :class => { }
    assert_redirected_to class_path(assigns(:class))
  end

  test "should destroy class" do
    assert_difference('Class.count', -1) do
      delete :destroy, :id => classes(:one).to_param
    end

    assert_redirected_to classes_path
  end
end
