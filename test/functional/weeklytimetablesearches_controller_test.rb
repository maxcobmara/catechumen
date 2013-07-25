require 'test_helper'

class WeeklytimetablesearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Weeklytimetablesearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Weeklytimetablesearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to weeklytimetablesearch_url(assigns(:weeklytimetablesearch))
  end

  def test_show
    get :show, :id => Weeklytimetablesearch.first
    assert_template 'show'
  end
end
