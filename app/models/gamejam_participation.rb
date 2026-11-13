class GamejamParticipation < ApplicationRecord
  belongs_to :joined_gamejam, class_name: "Gamejam"
  belongs_to :participant, class_name: "User"
end
