require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: { name: "", email: "test@user.com", password: "passwd", password_confirmation: "passwd" }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get signup_path
    email = "test@user.com"
    name = "test user name"
    assert_difference 'User.count', 1 do
      post signup_path, params: {
        user: { name: name, email: email, password: "passwd", password_confirmation: "passwd" }
      }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select "div.alert-success"
  end
end
