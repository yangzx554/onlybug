require 'test_helper'

class BuildsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:builds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_build
    assert_difference('Build.count') do
      post :create, :build => { }
    end

    assert_redirected_to build_path(assigns(:build))
  end

  def test_should_show_build
    get :show, :id => builds(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => builds(:one).id
    assert_response :success
  end

  def test_should_update_build
    put :update, :id => builds(:one).id, :build => { }
    assert_redirected_to build_path(assigns(:build))
  end

  def test_should_destroy_build
    assert_difference('Build.count', -1) do
      delete :destroy, :id => builds(:one).id
    end

    assert_redirected_to builds_path
  end
end
