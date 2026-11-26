class AddStatusToJamCommands < ActiveRecord::Migration[8.1]
  def change
    add_column :jam_commands, :status, :string, null: false
    change_column_default :jam_commands, :status, "Private"
  end
end
