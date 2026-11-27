class JamCommand < ApplicationRecord
  belongs_to :joined_jam, class_name: "Gamejam"
  has_one :jam_submission
  has_and_belongs_to_many :members, class_name: "User"

  validates :joined_jam, presence: true
  validates :name, presence: true, length: { in: 4..20 }
  validates :status, presence: true, inclusion: { in: %w(Private Solo Public), message: "%{value} is not a valid status"}
  
  def accessible?
    joined_jam.accessible? and (authored_by_current_user? or status != "Private")
  end

  def authored_by? (user_id)
    members.exists? user_id
  end

  def authored_by_current_user?
    !Current.nil? and !Current.session.nil? and (authored_by? Current.session.user.id)
  end
end

