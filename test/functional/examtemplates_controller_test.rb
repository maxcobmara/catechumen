require 'test_helper'

class ExamtemplatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examtemplates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examtemplate" do
    assert_difference('Examtemplate.count') do
      post :create, :examtemplate => { }
    end

    assert_redirected_to examtemplate_path(assigns(:examtemplate))
  end

  test "should show examtemplate" do
    get :show, :id => examtemplates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => examtemplates(:one).to_param
    assert_response :success
  end

  test "should update examtemplate" do
    put :update, :id => examtemplates(:one).to_param, :examtemplate => { }
    assert_redirected_to examtemplate_path(assigns(:examtemplate))
  end

  test "should destroy examtemplate" do
    assert_difference('Examtemplate.count', -1) do
      delete :destroy, :id => examtemplates(:one).to_param
    end

    assert_redirected_to examtemplates_path
  end
end
