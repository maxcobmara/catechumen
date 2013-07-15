class AddColumnsToStudentAttendance < ActiveRecord::Migration
  def self.up
    add_column :student_attendances, :reason, :string
    add_column :student_attendances, :action, :string
    add_column :student_attendances, :status, :string
    add_column :student_attendances, :remark, :string
  end

  def self.down
    remove_column :student_attendances, :remark
    remove_column :student_attendances, :status
    remove_column :student_attendances, :action
    remove_column :student_attendances, :reason
  end
end
