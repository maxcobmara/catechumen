require 'test_helper'

class AccessionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accession" do
    assert_difference('Accession.count') do
      post :create, :accession => { }
    end

    assert_redirected_to accession_path(assigns(:accession))
  end

  test "should show accession" do
    get :show, :id => accessions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => accessions(:one).to_param
    assert_response :success
  end

  test "should update accession" do
    put :update, :id => accessions(:one).to_param, :accession => { }
    assert_redirected_to accession_path(assigns(:accession))
  end

  test "should destroy accession" do
    assert_difference('Accession.count', -1) do
      delete :destroy, :id => accessions(:one).to_param
    end

    assert_redirected_to accessions_path
  end
end
