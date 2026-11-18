class Gamejam < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :jam_commands, inverse_of: "joined_jam", dependent: :destroy
  has_many :jam_submissions, through: :jam_commands
  has_many :members, through: :jam_commands, class_name: "User"

  validates :name, presence: true, uniqueness: true, length: { in: 6..20 }
  validates :theme, presence: true, length: { in: 1..30 }
  validates :status, presence: true, inclusion: { in: %w(Draft Published Ongoing Finished), message: "%{value} is not a valid status"}
  validates :author, presence: true

  def published?
    status != "Draft"
  end

  def was_started?
    status == "Ongoing" or status == "Finished"
  end

  def draft?
    status == "Draft"
  end

  def accessible?
    published? or authored_by_current_user?
  end

  def authored_by? (user)
    user == author
  end

  def authored_by_current_user?
    !Current.nil? and !Current.session.nil? and (authored_by? Current.session.user)
  end

end
