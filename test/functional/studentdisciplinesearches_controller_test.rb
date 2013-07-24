require 'test_helper'

class StudentdisciplinesearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Studentdisciplinesearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Studentdisciplinesearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to studentdisciplinesearch_url(assigns(:studentdisciplinesearch))
  end

  def test_show
    get :show, :id => Studentdisciplinesearch.first
    assert_template 'show'
  end
end
