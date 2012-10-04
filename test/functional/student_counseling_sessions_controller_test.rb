require 'test_helper'

class StudentCounselingSessionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_counseling_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_counseling_session" do
    assert_difference('StudentCounselingSession.count') do
      post :create, :student_counseling_session => { }
    end

    assert_redirected_to student_counseling_session_path(assigns(:student_counseling_session))
  end

  test "should show student_counseling_session" do
    get :show, :id => student_counseling_sessions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => student_counseling_sessions(:one).to_param
    assert_response :success
  end

  test "should update student_counseling_session" do
    put :update, :id => student_counseling_sessions(:one).to_param, :student_counseling_session => { }
    assert_redirected_to student_counseling_session_path(assigns(:student_counseling_session))
  end

  test "should destroy student_counseling_session" do
    assert_difference('StudentCounselingSession.count', -1) do
      delete :destroy, :id => student_counseling_sessions(:one).to_param
    end

    assert_redirected_to student_counseling_sessions_path
  end
end
