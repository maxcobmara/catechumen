require 'test_helper'

class EvaluatecoursesearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Evaluatecoursesearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Evaluatecoursesearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to evaluatecoursesearch_url(assigns(:evaluatecoursesearch))
  end

  def test_show
    get :show, :id => Evaluatecoursesearch.first
    assert_template 'show'
  end
end
