class CreateGamejams < ActiveRecord::Migration[8.1]
  def change
    create_table :gamejams do |t|
      t.string :name, null: false
      t.text :description
      t.string :theme, null: false

      t.timestamps
    end
  end
end
