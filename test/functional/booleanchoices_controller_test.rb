require 'test_helper'

class BooleanchoicesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booleanchoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booleanchoice" do
    assert_difference('Booleanchoice.count') do
      post :create, :booleanchoice => { }
    end

    assert_redirected_to booleanchoice_path(assigns(:booleanchoice))
  end

  test "should show booleanchoice" do
    get :show, :id => booleanchoices(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => booleanchoices(:one).to_param
    assert_response :success
  end

  test "should update booleanchoice" do
    put :update, :id => booleanchoices(:one).to_param, :booleanchoice => { }
    assert_redirected_to booleanchoice_path(assigns(:booleanchoice))
  end

  test "should destroy booleanchoice" do
    assert_difference('Booleanchoice.count', -1) do
      delete :destroy, :id => booleanchoices(:one).to_param
    end

    assert_redirected_to booleanchoices_path
  end
end
