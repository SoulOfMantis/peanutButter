require_relative "20261106161106_create_gamejam_participations"
class DropTableGamejamParticipations < ActiveRecord::Migration[8.1]
  def change
    revert CreateGamejamParticipations
  end
end

