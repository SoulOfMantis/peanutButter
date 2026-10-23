class AddAuthorAndGamejamToJamSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_reference :jam_submissions, :author, null: false, foreign_key: {to_table: :users}
    add_reference :jam_submissions, :gamejam, null: false, foreign_key: true
  end
end
