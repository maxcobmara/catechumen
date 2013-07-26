require 'test_helper'

class CurriculumsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Curriculumsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Curriculumsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to curriculumsearch_url(assigns(:curriculumsearch))
  end

  def test_show
    get :show, :id => Curriculumsearch.first
    assert_template 'show'
  end
end
