require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @other_user = users(:michael)
    @task = @user.tasks.first
  end

  test "new before log in should redirect to login_url" do
    get new_task_path
    assert_redirected_to login_url
  end

  test "update before log in should redirect to login_url" do
    patch task_path(@task)
    assert_redirected_to login_url
  end

  test "create before log in should redirect to login_url" do
    post tasks_path, params: {
      task: { content: "aa", deadline: Time.zone.now, status: :untouched }
    }
    assert_redirected_to login_url
  end

  test "edit before log in should redirect to login_url" do
    get edit_task_path(@user.tasks.first)
    assert_redirected_to login_url
  end

  test "edit path for correct task should success" do
    log_in_as(@user)
    get edit_task_path(@task)
    assert_template 'tasks/edit'
  end

  test "edit path for other user should redirect to user page" do
    log_in_as(@other_user)
    get edit_task_path(@task)
    assert_redirected_to user_path(@other_user)
  end
end
