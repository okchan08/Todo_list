require 'test_helper'

class TaskListTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "user page should contain tasks" do
    get user_path(@user)
    assert_template 'users/show'
    tasks = @user.tasks.paginate(page: 1)
    tasks.each do |t|
      assert_match t.content, response.body
    end
  end
end
