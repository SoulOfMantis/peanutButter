class JamCommand < ApplicationRecord
  belongs_to :joined_jam, class_name: "Gamejam"
  has_one :jam_submission
  has_and_belongs_to_many :members, class_name: "User"

  validates :joined_jam, presence: true
  validates :name, presence: true, length: { in: 4..20 }

end

