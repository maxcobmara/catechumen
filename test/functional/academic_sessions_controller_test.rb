require 'test_helper'

class AcademicSessionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academic_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academic_session" do
    assert_difference('AcademicSession.count') do
      post :create, :academic_session => { }
    end

    assert_redirected_to academic_session_path(assigns(:academic_session))
  end

  test "should show academic_session" do
    get :show, :id => academic_sessions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => academic_sessions(:one).to_param
    assert_response :success
  end

  test "should update academic_session" do
    put :update, :id => academic_sessions(:one).to_param, :academic_session => { }
    assert_redirected_to academic_session_path(assigns(:academic_session))
  end

  test "should destroy academic_session" do
    assert_difference('AcademicSession.count', -1) do
      delete :destroy, :id => academic_sessions(:one).to_param
    end

    assert_redirected_to academic_sessions_path
  end
end
