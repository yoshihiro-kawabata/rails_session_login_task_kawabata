class AddUseridToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :user_id, :integer, foreign_key: true 
  end
end
