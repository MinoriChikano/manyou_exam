class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :task_name, false
  end
end
