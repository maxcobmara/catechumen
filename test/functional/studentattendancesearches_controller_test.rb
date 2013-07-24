require 'test_helper'

class StudentattendancesearchesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Studentattendancesearch.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Studentattendancesearch.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to studentattendancesearch_url(assigns(:studentattendancesearch))
  end

  def test_show
    get :show, :id => Studentattendancesearch.first
    assert_template 'show'
  end
end
