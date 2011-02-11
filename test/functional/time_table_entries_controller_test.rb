require 'test_helper'

class TimeTableEntriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_table_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_table_entry" do
    assert_difference('TimeTableEntry.count') do
      post :create, :time_table_entry => { }
    end

    assert_redirected_to time_table_entry_path(assigns(:time_table_entry))
  end

  test "should show time_table_entry" do
    get :show, :id => time_table_entries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => time_table_entries(:one).to_param
    assert_response :success
  end

  test "should update time_table_entry" do
    put :update, :id => time_table_entries(:one).to_param, :time_table_entry => { }
    assert_redirected_to time_table_entry_path(assigns(:time_table_entry))
  end

  test "should destroy time_table_entry" do
    assert_difference('TimeTableEntry.count', -1) do
      delete :destroy, :id => time_table_entries(:one).to_param
    end

    assert_redirected_to time_table_entries_path
  end
end
