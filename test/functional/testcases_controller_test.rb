require 'test_helper'

class TestcasesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:testcases)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_testcase
    assert_difference('Testcase.count') do
      post :create, :testcase => { }
    end

    assert_redirected_to testcase_path(assigns(:testcase))
  end

  def test_should_show_testcase
    get :show, :id => testcases(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => testcases(:one).id
    assert_response :success
  end

  def test_should_update_testcase
    put :update, :id => testcases(:one).id, :testcase => { }
    assert_redirected_to testcase_path(assigns(:testcase))
  end

  def test_should_destroy_testcase
    assert_difference('Testcase.count', -1) do
      delete :destroy, :id => testcases(:one).id
    end

    assert_redirected_to testcases_path
  end
end
