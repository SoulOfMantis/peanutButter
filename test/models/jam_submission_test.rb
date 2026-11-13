require "test_helper"

class JamSubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "is a draft when status is Draft" do
    draft = JamSubmission.new status: "Draft"
    assert draft.draft?
  end
  test "is a draft by default" do
    draft = JamSubmission.new
    assert draft.draft?
  end
  test "is authored by it's author" do
    author = User.new
    draft = JamSubmission.new author: author
    assert draft.authored_by? author
  end

end
