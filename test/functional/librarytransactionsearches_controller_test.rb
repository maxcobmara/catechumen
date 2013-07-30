require 'test_helper'

class LibrarytransactionsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Librarytransactionsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Librarytransactionsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to librarytransactionsearch_url(assigns(:librarytransactionsearch))
  end

  def test_show
    get :show, :id => Librarytransactionsearch.first
    assert_template 'show'
  end
end
