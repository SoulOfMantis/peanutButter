class UpdateStatusInGamejams < ActiveRecord::Migration[8.1]
  def up
    change_column_default :gamejams, :status, "Draft"
  end
end
