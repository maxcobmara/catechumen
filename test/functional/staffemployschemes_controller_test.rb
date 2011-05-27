require 'test_helper'

class StaffemployschemesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffemployschemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffemployscheme" do
    assert_difference('Staffemployscheme.count') do
      post :create, :staffemployscheme => { }
    end

    assert_redirected_to staffemployscheme_path(assigns(:staffemployscheme))
  end

  test "should show staffemployscheme" do
    get :show, :id => staffemployschemes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffemployschemes(:one).to_param
    assert_response :success
  end

  test "should update staffemployscheme" do
    put :update, :id => staffemployschemes(:one).to_param, :staffemployscheme => { }
    assert_redirected_to staffemployscheme_path(assigns(:staffemployscheme))
  end

  test "should destroy staffemployscheme" do
    assert_difference('Staffemployscheme.count', -1) do
      delete :destroy, :id => staffemployschemes(:one).to_param
    end

    assert_redirected_to staffemployschemes_path
  end
end
