require 'test_helper'

class ExamsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Examsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Examsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to examsearch_url(assigns(:examsearch))
  end

  def test_show
    get :show, :id => Examsearch.first
    assert_template 'show'
  end
end
