class ChangePriorityDefaultOnTasks < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :tasks, :priority, :integer, default: 0
    end

    def down
      change_column :tasks, :priority, :integer, default: false
    end
  end
end
