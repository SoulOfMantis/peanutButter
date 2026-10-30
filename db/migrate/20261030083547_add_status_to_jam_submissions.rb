class AddStatusToJamSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_column :jam_submissions, :status, :string
    change_column_default :jam_submissions, :status, "Draft"
  end
end
