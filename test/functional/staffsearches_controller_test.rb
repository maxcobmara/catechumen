require 'test_helper'

class StaffsearchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffsearches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staffsearch" do
    assert_difference('Staffsearch.count') do
      post :create, :staffsearch => { }
    end

    assert_redirected_to staffsearch_path(assigns(:staffsearch))
  end

  test "should show staffsearch" do
    get :show, :id => staffsearches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staffsearches(:one).to_param
    assert_response :success
  end

  test "should update staffsearch" do
    put :update, :id => staffsearches(:one).to_param, :staffsearch => { }
    assert_redirected_to staffsearch_path(assigns(:staffsearch))
  end

  test "should destroy staffsearch" do
    assert_difference('Staffsearch.count', -1) do
      delete :destroy, :id => staffsearches(:one).to_param
    end

    assert_redirected_to staffsearches_path
  end
end
