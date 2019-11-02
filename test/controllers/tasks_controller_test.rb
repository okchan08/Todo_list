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

  test "update for incorrect task should redirect to user page" do
    log_in_as(@other_user)
    patch task_path(@task), params: {
      task: {
        content: "test",
      }
    }
    assert_redirected_to user_path(@other_user)
    follow_redirect!
    assert_select "div.alert-danger", count: 1
  end

  test "update task without login should redirect to user page" do
    patch task_path(@task), params: {
      task: {
        content: "test",
      }
    }
    assert_redirected_to login_path
  end

  test "update path for correct task should success" do
    log_in_as(@user)
    content = "新しい内容"
    deadline = Time.current.since(3.days)
    patch task_path(@task), params: {
      task: {
        content: content,
        deadline: deadline
      }
    }
    @task.reload
    assert_redirected_to edit_task_path(@task)
    follow_redirect!
    assert_select "div.alert-success", count: 1
    assert_equal content, @task.content
    assert_equal deadline.to_s(:date), @task.deadline.to_s(:date)
  end

  test "update with invalid parameter" do
    log_in_as(@user)
    content_before = @task.content
    patch task_path(@task), params: {
      task: {
        content: "",
        deadline: @task.deadline
      }
    }
    assert_select "div.alert-danger"
    assert_equal content_before, @task.content
  end
end
