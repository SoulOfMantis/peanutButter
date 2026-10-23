class AddDetailsToGamejams < ActiveRecord::Migration[8.1]
  def change
    add_column :gamejams, :status, :string, null: false
    add_column :gamejams, :start_date, :date
    add_column :gamejams, :end_date, :date
  end
end
