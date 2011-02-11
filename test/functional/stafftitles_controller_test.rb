require 'test_helper'

class StafftitlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stafftitles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stafftitle" do
    assert_difference('Stafftitle.count') do
      post :create, :stafftitle => { }
    end

    assert_redirected_to stafftitle_path(assigns(:stafftitle))
  end

  test "should show stafftitle" do
    get :show, :id => stafftitles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stafftitles(:one).to_param
    assert_response :success
  end

  test "should update stafftitle" do
    put :update, :id => stafftitles(:one).to_param, :stafftitle => { }
    assert_redirected_to stafftitle_path(assigns(:stafftitle))
  end

  test "should destroy stafftitle" do
    assert_difference('Stafftitle.count', -1) do
      delete :destroy, :id => stafftitles(:one).to_param
    end

    assert_redirected_to stafftitles_path
  end
end
