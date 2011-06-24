require 'test_helper'

class PtcoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ptcourses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ptcourse" do
    assert_difference('Ptcourse.count') do
      post :create, :ptcourse => { }
    end

    assert_redirected_to ptcourse_path(assigns(:ptcourse))
  end

  test "should show ptcourse" do
    get :show, :id => ptcourses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ptcourses(:one).to_param
    assert_response :success
  end

  test "should update ptcourse" do
    put :update, :id => ptcourses(:one).to_param, :ptcourse => { }
    assert_redirected_to ptcourse_path(assigns(:ptcourse))
  end

  test "should destroy ptcourse" do
    assert_difference('Ptcourse.count', -1) do
      delete :destroy, :id => ptcourses(:one).to_param
    end

    assert_redirected_to ptcourses_path
  end
end
