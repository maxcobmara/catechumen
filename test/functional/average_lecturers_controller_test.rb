require 'test_helper'

class AverageLecturersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:average_lecturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create average_lecturer" do
    assert_difference('AverageLecturer.count') do
      post :create, :average_lecturer => { }
    end

    assert_redirected_to average_lecturer_path(assigns(:average_lecturer))
  end

  test "should show average_lecturer" do
    get :show, :id => average_lecturers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => average_lecturers(:one).to_param
    assert_response :success
  end

  test "should update average_lecturer" do
    put :update, :id => average_lecturers(:one).to_param, :average_lecturer => { }
    assert_redirected_to average_lecturer_path(assigns(:average_lecturer))
  end

  test "should destroy average_lecturer" do
    assert_difference('AverageLecturer.count', -1) do
      delete :destroy, :id => average_lecturers(:one).to_param
    end

    assert_redirected_to average_lecturers_path
  end
end
