require 'test_helper'

class PersonalizetimetablesearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Personalizetimetablesearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Personalizetimetablesearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to personalizetimetablesearch_url(assigns(:personalizetimetablesearch))
  end

  def test_show
    get :show, :id => Personalizetimetablesearch.first
    assert_template 'show'
  end
end
