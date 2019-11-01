class AddIndexToTask < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:user_id, :created_at]
    add_index :tasks, [:user_id, :deadline]
  end
end
