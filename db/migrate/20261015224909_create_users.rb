class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :created_at

      t.timestamps
    end
  end
end
