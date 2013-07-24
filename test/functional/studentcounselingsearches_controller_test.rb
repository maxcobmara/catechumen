require 'test_helper'

class StudentcounselingsearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Studentcounselingsearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Studentcounselingsearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to studentcounselingsearch_url(assigns(:studentcounselingsearch))
  end

  def test_show
    get :show, :id => Studentcounselingsearch.first
    assert_template 'show'
  end
end
