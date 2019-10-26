require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
      session: { email: "ahoaho@example.com", password: "invalid" }
    }

    assert_template 'sessions/new'
    assert_select 'div.alert-danger'
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {
      session: { email: @user.email, password: "password" }
    }

    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end
end
