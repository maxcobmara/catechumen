require 'test_helper'

class DocumentsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Documentsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Documentsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to documentsearch_url(assigns(:documentsearch))
  end

  def test_show
    get :show, :id => Documentsearch.first
    assert_template 'show'
  end
end
