require 'test_helper'

class ExamanalysissearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Examanalysissearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Examanalysissearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to examanalysissearch_url(assigns(:examanalysissearch))
  end

  def test_show
    get :show, :id => Examanalysissearch.first
    assert_template 'show'
  end
end
