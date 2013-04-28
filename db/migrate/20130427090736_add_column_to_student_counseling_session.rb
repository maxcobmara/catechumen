class AddColumnToStudentCounselingSession < ActiveRecord::Migration
  def self.up
    add_column :student_counseling_sessions, :remark, :text
  end

  def self.down
    remove_column :student_counseling_sessions, :remark
  end
end
