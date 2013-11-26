require 'test_helper'

class AddressBookItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_book_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address_book_item" do
    assert_difference('AddressBookItem.count') do
      post :create, :address_book_item => { }
    end

    assert_redirected_to address_book_item_path(assigns(:address_book_item))
  end

  test "should show address_book_item" do
    get :show, :id => address_book_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => address_book_items(:one).to_param
    assert_response :success
  end

  test "should update address_book_item" do
    put :update, :id => address_book_items(:one).to_param, :address_book_item => { }
    assert_redirected_to address_book_item_path(assigns(:address_book_item))
  end

  test "should destroy address_book_item" do
    assert_difference('AddressBookItem.count', -1) do
      delete :destroy, :id => address_book_items(:one).to_param
    end

    assert_redirected_to address_book_items_path
  end
end
