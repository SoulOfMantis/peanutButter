class JamSubmission < ApplicationRecord
  has_one_attached :game_build
  belongs_to :jam_command
  has_many :members, class_name: "User", through: :jam_command
  has_one :joined_jam, class_name: "Gamejam", through: :jam_command

  validates :name, presence: true, length: { in: 6..25 }
  validates :jam_command, presence: true
  validates :status, presence: true, inclusion: { in: %w(Draft Published), message: "%{value} is not a valid status"}

  def published?
    status != "Draft"
  end

  def draft?
    status == "Draft"
  end

  def accessible?
    joined_jam.theme_available? and (published? or authored_by_current_user?)
  end

  def authored_by? (user_id)
    members.exists? user_id
  end

  def authored_by_current_user?
    !Current.nil? and !Current.session.nil? and (authored_by? Current.session.user.id)
  end

  def editable?
    accessible? and authored_by_current_user? and !joined_jam.finished?  
  end

end
