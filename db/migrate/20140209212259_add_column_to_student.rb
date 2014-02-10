class AddColumnToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :course_remarks, :string
  end

  def self.down
    remove_column :students, :course_remarks
  end
end
