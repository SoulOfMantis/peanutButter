class CreateJamCommands < ActiveRecord::Migration[8.1]
  def change
    create_table :jam_commands do |t|
      t.string :name, null: false
      t.text :description
      t.belongs_to :joined_jam, null: false, foreign_key: {to_table: :gamejams}

      t.timestamps
    end
    
    add_reference :jam_submissions, :jam_command, null: false, foreign_key: true
    remove_reference :jam_submissions, :author, foreign_key: {to_table: :users}
    remove_reference :jam_submissions, :gamejam, foreign_key: {to_table: :gamejams}

    create_table :jam_commands_users, id: false do |t|
      t.belongs_to :jam_command
      t.belongs_to :user, foreign_key: {to_table: :users}
    end

  end
end
