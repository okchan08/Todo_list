require 'test_helper'

class TaskListTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    log_in_as(@user)
  end

  test "user page should contain tasks" do
    get user_path(@user)
    assert_template 'users/show'
    tasks = @user.tasks.paginate(page: 1)
    assert_not tasks.empty?
    tasks.each do |task|
      assert_match task.content, response.body
      assert_select "a[href=?]", edit_task_path(task), text: task.content
    end
  end
end
