require_relative "20261022215554_create_join_table_users_gamejams"
class DeleteTableGamejamParticipants < ActiveRecord::Migration[8.1]
  def change
    revert CreateJoinTableUsersGamejams
  end
end
