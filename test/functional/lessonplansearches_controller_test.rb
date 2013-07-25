require 'test_helper'

class LessonplansearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Lessonplansearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Lessonplansearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to lessonplansearch_url(assigns(:lessonplansearch))
  end

  def test_show
    get :show, :id => Lessonplansearch.first
    assert_template 'show'
  end
end
