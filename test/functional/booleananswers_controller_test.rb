require 'test_helper'

class BooleananswersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booleananswers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booleananswer" do
    assert_difference('Booleananswer.count') do
      post :create, :booleananswer => { }
    end

    assert_redirected_to booleananswer_path(assigns(:booleananswer))
  end

  test "should show booleananswer" do
    get :show, :id => booleananswers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => booleananswers(:one).to_param
    assert_response :success
  end

  test "should update booleananswer" do
    put :update, :id => booleananswers(:one).to_param, :booleananswer => { }
    assert_redirected_to booleananswer_path(assigns(:booleananswer))
  end

  test "should destroy booleananswer" do
    assert_difference('Booleananswer.count', -1) do
      delete :destroy, :id => booleananswers(:one).to_param
    end

    assert_redirected_to booleananswers_path
  end
end
