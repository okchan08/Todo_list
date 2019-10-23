require 'test_helper'

class AppicationHelperTest < ActionView::TestCase
  test "full title test" do
    assert_equal full_title, "TodoList"
    assert_equal full_title("Test"), "Test | TodoList"
  end
end