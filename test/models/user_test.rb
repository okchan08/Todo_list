require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "test user", email: "user@test.com",
                      password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "user name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "email format check" do
    @user.email = "email.com"
    assert_not @user.valid?
  end

  test "user name should be less than 50" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user email should be less than 255" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "user email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be set" do
    @user.password = " " * 6
    @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be longer than 6" do
    @user.password = "12345"
    @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

  test "associated tasks should be deleted" do
    @user.save
    @user.tasks.create!(content: "task")
    assert_difference 'Task.count', -1 do
      @user.destroy
    end
  end
end
