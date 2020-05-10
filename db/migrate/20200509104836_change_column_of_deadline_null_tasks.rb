class ChangeColumnOfDeadlineNullTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :deadline, false
    change_column :tasks, :deadline, :date, default: -> { 'NOW()' }

  end

  def down
    change_column_null :tasks, :deadline, true, nil
    change_column :tasks, :deadline, :date, default:nil
  end
end
