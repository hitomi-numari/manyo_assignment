class ChangeStatusDefaultOnTasks < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :tasks, :status, :integer, default: 0
    end

    def down
      change_column :tasks, :status, :integer, default: false
    end
  end
end
