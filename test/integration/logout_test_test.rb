require 'test_helper'

class LogoutTestTest < ActionDispatch::IntegrationTest
  test "logout" do
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select "div.alert-info"
    assert_not logged_in?
  end

end
