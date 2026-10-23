class CreateJoinTableUsersGamejams < ActiveRecord::Migration[8.1]
  def change
    create_join_table :users, :gamejams, table_name: :gamejam_participants do |t|
      # t.index [:user_id, :gamejam_id]
      # t.index [:gamejam_id, :user_id]
    end
  end
end
