require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @task = @user.tasks.build(content: "What I have to do")
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "task content should be less than 140" do
    @task.content = "a" * 141
    assert_not @task.valid?
  end

  test "task content should be present" do
    @task.content = "    "
    assert_not @task.valid?
  end
end
