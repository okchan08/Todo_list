require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {
      session: { email: "ahoaho@example.com", password: "invalid" }
    }

    assert_template 'sessions/new'
    assert_select 'div.alert-danger'
    assert_not logged_in?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: {
      session: { email: @user.email, password: "password" }
    }

    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
    assert_equal @user.id, current_user.id
  end

  test "login and access other user page" do
    get login_path
    post login_path, params: {
      session: { email: @user.email, password: "password" }
    }

    assert_equal @user.id, current_user.id
    assert_not_equal @other_user.id, current_user.id

    get user_path(@other_user)
    assert_template 'errors/show'
    msg = "このページは閲覧できません．"
    assert_match msg, response.body
  end

  test "logout" do
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select "div.alert-info"
    assert_not logged_in?
  end
end
