class CreateGamejamParticipations < ActiveRecord::Migration[8.1]
  def change
    create_table :gamejam_participations do |t|
      t.belongs_to :participant, null: false, foreign_key: {to_table: :users}
      t.belongs_to :joined_gamejam, null: false, foreign_key: {to_table: :gamejams}

      t.timestamps
    end
  end
end

