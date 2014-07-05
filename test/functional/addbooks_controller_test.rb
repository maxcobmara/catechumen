require 'test_helper'

class AddressBooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address_book" do
    assert_difference('AddressBook.count') do
      post :create, :address_book => { }
    end

    assert_redirected_to address_book_path(assigns(:address_book))
  end

  test "should show address_book" do
    get :show, :id => address_books(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => address_books(:one).to_param
    assert_response :success
  end

  test "should update address_book" do
    put :update, :id => address_books(:one).to_param, :address_book => { }
    assert_redirected_to address_book_path(assigns(:address_book))
  end

  test "should destroy address_book" do
    assert_difference('AddressBook.count', -1) do
      delete :destroy, :id => address_books(:one).to_param
    end

    assert_redirected_to address_books_path
  end
end
