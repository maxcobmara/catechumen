require 'test_helper'

class SktStaffsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skt_staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skt_staff" do
    assert_difference('SktStaff.count') do
      post :create, :skt_staff => { }
    end

    assert_redirected_to skt_staff_path(assigns(:skt_staff))
  end

  test "should show skt_staff" do
    get :show, :id => skt_staffs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => skt_staffs(:one).to_param
    assert_response :success
  end

  test "should update skt_staff" do
    put :update, :id => skt_staffs(:one).to_param, :skt_staff => { }
    assert_redirected_to skt_staff_path(assigns(:skt_staff))
  end

  test "should destroy skt_staff" do
    assert_difference('SktStaff.count', -1) do
      delete :destroy, :id => skt_staffs(:one).to_param
    end

    assert_redirected_to skt_staffs_path
  end
end
