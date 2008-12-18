require 'test_helper'

class MilestonesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:milestones)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_milestone
    assert_difference('Milestone.count') do
      post :create, :milestone => { }
    end

    assert_redirected_to milestone_path(assigns(:milestone))
  end

  def test_should_show_milestone
    get :show, :id => milestones(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => milestones(:one).id
    assert_response :success
  end

  def test_should_update_milestone
    put :update, :id => milestones(:one).id, :milestone => { }
    assert_redirected_to milestone_path(assigns(:milestone))
  end

  def test_should_destroy_milestone
    assert_difference('Milestone.count', -1) do
      delete :destroy, :id => milestones(:one).id
    end

    assert_redirected_to milestones_path
  end
end
