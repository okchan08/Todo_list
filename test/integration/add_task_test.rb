require 'test_helper'

class AddTaskTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @task = Task.new(content: "test", deadline: Time.zone.tomorrow)
  end

  test "create without log in redirect_to login_path" do
    assert_no_difference 'Task.count' do
      post tasks_path, params: {
        task: {
          content: @task.content,
          deadline: @task.deadline
        }
      }
    end
    assert_redirected_to login_path
  end

  test "create task success" do
    log_in_as(@user)
    assert_difference 'Task.count', 1 do
      post tasks_path, params: {
        task: {
          content: @task.content,
          deadline: @task.deadline
        }
      }
    end
  end

  test "invalid task info" do
    log_in_as(@user)
    assert_no_difference 'Task.count' do
      post tasks_path, params: {
        task: {
          content: "",
          deadline: ""
        }
      }
    end
  end
end
