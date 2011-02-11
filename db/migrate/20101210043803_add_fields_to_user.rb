class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :staff_id, :integer
    add_column :users, :student_id, :integer
  end

  def self.down
    remove_column :users, :student_id
    remove_column :users, :staff_id
  end
end
