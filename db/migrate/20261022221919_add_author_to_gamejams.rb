class AddAuthorToGamejams < ActiveRecord::Migration[8.1]
  def change
    add_reference :gamejams, :author, null: false, foreign_key: {to_table: :users}
  end
end
