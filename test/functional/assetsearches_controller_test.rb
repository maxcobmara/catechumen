require 'test_helper'

class AssetsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Assetsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Assetsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to assetsearch_url(assigns(:assetsearch))
  end

  def test_show
    get :show, :id => Assetsearch.first
    assert_template 'show'
  end
end
