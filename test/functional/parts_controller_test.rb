require 'test_helper'

class PartsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part" do
    assert_difference('Part.count') do
      post :create, :part => { }
    end

    assert_redirected_to part_path(assigns(:part))
  end

  test "should show part" do
    get :show, :id => parts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => parts(:one).to_param
    assert_response :success
  end

  test "should update part" do
    put :update, :id => parts(:one).to_param, :part => { }
    assert_redirected_to part_path(assigns(:part))
  end

  test "should destroy part" do
    assert_difference('Part.count', -1) do
      delete :destroy, :id => parts(:one).to_param
    end

    assert_redirected_to parts_path
  end
end
