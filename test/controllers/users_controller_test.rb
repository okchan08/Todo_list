require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get sign up" do
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "GET user path should redirect info when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
