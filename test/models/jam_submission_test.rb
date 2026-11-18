require "test_helper"

class JamSubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "is a draft when status is Draft" do
    draft = JamSubmission.new status: "Draft"
    assert draft.draft?
  end
  test "is authored by every it's author" do
    command = JamCommand.new    
    author1 = User.new
    author2 = User.new
    command.members<< author1
    command.members<< author2
    draft = JamSubmission.new jam_command: command
    assert draft.authored_by?(author1)
    assert draft.authored_by?(author2)
  end

end
