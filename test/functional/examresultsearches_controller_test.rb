require 'test_helper'

class ExamresultsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Examresultsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Examresultsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to examresultsearch_url(assigns(:examresultsearch))
  end

  def test_show
    get :show, :id => Examresultsearch.first
    assert_template 'show'
  end
end
