require 'test_helper'

class BulletinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulletins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bulletin" do
    assert_difference('Bulletin.count') do
      post :create, :bulletin => { }
    end

    assert_redirected_to bulletin_path(assigns(:bulletin))
  end

  test "should show bulletin" do
    get :show, :id => bulletins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bulletins(:one).to_param
    assert_response :success
  end

  test "should update bulletin" do
    put :update, :id => bulletins(:one).to_param, :bulletin => { }
    assert_redirected_to bulletin_path(assigns(:bulletin))
  end

  test "should destroy bulletin" do
    assert_difference('Bulletin.count', -1) do
      delete :destroy, :id => bulletins(:one).to_param
    end

    assert_redirected_to bulletins_path
  end
end
