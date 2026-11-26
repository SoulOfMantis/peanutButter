class JamSubmission < ApplicationRecord
  belongs_to :jam_command
  has_many :members, class_name: "User", through: :jam_command
  has_one :joined_jam, class_name: "Gamejam", through: :jam_command

  validates :name, presence: true, length: { in: 6..20 }
  validates :jam_command, presence: true
  validates :status, presence: true, inclusion: { in: %w(Draft Published), message: "%{value} is not a valid status"}

  def published?
    status != "Draft"
  end

  def draft?
    status == "Draft"
  end

  def accessible?
    published? or authored_by_current_user?
  end

  def authored_by? (user_id)
    members.exists? user_id
  end

  def authored_by_current_user?
    !Current.nil? and !Current.session.nil? and (authored_by? Current.session.user.id)
  end

end
