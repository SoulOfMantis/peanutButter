class AddNameAndNicknameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :nickname, :string, null: false
  end
end
