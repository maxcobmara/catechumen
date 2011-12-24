require 'test_helper'

class StudentattendancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studentattendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studentattendance" do
    assert_difference('Studentattendance.count') do
      post :create, :studentattendance => { }
    end

    assert_redirected_to studentattendance_path(assigns(:studentattendance))
  end

  test "should show studentattendance" do
    get :show, :id => studentattendances(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => studentattendances(:one).to_param
    assert_response :success
  end

  test "should update studentattendance" do
    put :update, :id => studentattendances(:one).to_param, :studentattendance => { }
    assert_redirected_to studentattendance_path(assigns(:studentattendance))
  end

  test "should destroy studentattendance" do
    assert_difference('Studentattendance.count', -1) do
      delete :destroy, :id => studentattendances(:one).to_param
    end

    assert_redirected_to studentattendances_path
  end
end
