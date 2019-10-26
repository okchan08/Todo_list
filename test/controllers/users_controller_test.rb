require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get sign up" do
    get signup_path
    assert_select "title", full_title("Sign up")
  end

end
