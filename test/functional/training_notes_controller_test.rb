require 'test_helper'

class TrainingNotesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_note" do
    assert_difference('TrainingNote.count') do
      post :create, :training_note => { }
    end

    assert_redirected_to training_note_path(assigns(:training_note))
  end

  test "should show training_note" do
    get :show, :id => training_notes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => training_notes(:one).to_param
    assert_response :success
  end

  test "should update training_note" do
    put :update, :id => training_notes(:one).to_param, :training_note => { }
    assert_redirected_to training_note_path(assigns(:training_note))
  end

  test "should destroy training_note" do
    assert_difference('TrainingNote.count', -1) do
      delete :destroy, :id => training_notes(:one).to_param
    end

    assert_redirected_to training_notes_path
  end
end
