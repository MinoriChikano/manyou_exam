class AddExpiredAtToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expired_at, :datetime, null: false, default: -> { 'NOW()' }
  end
end
