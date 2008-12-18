require 'test_helper'

class PageHistoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:page_histories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_page_history
    assert_difference('PageHistory.count') do
      post :create, :page_history => { }
    end

    assert_redirected_to page_history_path(assigns(:page_history))
  end

  def test_should_show_page_history
    get :show, :id => page_histories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => page_histories(:one).id
    assert_response :success
  end

  def test_should_update_page_history
    put :update, :id => page_histories(:one).id, :page_history => { }
    assert_redirected_to page_history_path(assigns(:page_history))
  end

  def test_should_destroy_page_history
    assert_difference('PageHistory.count', -1) do
      delete :destroy, :id => page_histories(:one).id
    end

    assert_redirected_to page_histories_path
  end
end
