require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end
  test "requires a long password" do
    weak_password = "123"
    user = User.new password: weak_password, password_confirmation: 
      weak_password, nickname: "user", name: "name", email_address: "example@example.com"
    assert_not user.save "Saved with a short password"
  end

end
