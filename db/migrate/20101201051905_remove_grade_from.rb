class RemoveGradeFrom < ActiveRecord::Migration
  def self.up
    remove_column :staffs, :grade
  end

  def self.down
    add_column :staffs, :grade, :string
  end
end
