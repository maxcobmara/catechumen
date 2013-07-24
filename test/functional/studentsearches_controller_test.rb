require 'test_helper'

class StudentsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Studentsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Studentsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to studentsearch_url(assigns(:studentsearch))
  end

  def test_show
    get :show, :id => Studentsearch.first
    assert_template 'show'
  end
end
