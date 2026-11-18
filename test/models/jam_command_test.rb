require "test_helper"

class JamCommandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "requires a name in 4..20 symbols" do
    short_name = "123"
    long_name = "012345678901234567890123456789"
    jc = JamCommand.new joined_jam: Gamejam.first
    jc.members << User.first
    jc.name = short_name
    assert_not jc.save, "Saved with a short name"
    jc.name = long_name
    assert_not jc.save, "Saved with a long name"
  end

end
