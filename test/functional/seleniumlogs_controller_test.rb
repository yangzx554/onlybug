require 'test_helper'

class SeleniumlogsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:seleniumlogs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_seleniumlog
    assert_difference('Seleniumlog.count') do
      post :create, :seleniumlog => { }
    end

    assert_redirected_to seleniumlog_path(assigns(:seleniumlog))
  end

  def test_should_show_seleniumlog
    get :show, :id => seleniumlogs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => seleniumlogs(:one).id
    assert_response :success
  end

  def test_should_update_seleniumlog
    put :update, :id => seleniumlogs(:one).id, :seleniumlog => { }
    assert_redirected_to seleniumlog_path(assigns(:seleniumlog))
  end

  def test_should_destroy_seleniumlog
    assert_difference('Seleniumlog.count', -1) do
      delete :destroy, :id => seleniumlogs(:one).id
    end

    assert_redirected_to seleniumlogs_path
  end
end
