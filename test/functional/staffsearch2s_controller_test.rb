require 'test_helper'

class Staffsearch2sControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Staffsearch2.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Staffsearch2.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to staffsearch2_url(assigns(:staffsearch2))
  end

  def test_show
    get :show, :id => Staffsearch2.first
    assert_template 'show'
  end
end
