class AddTaskOtherColumnIntoPositions < ActiveRecord::Migration
  def self.up
      add_column :positions, :tasks_other, :text
  end

  def self.down
      remove_column :positions, :tasks_other
  end
end
