class AddColumnToStudentDisciplineCase < ActiveRecord::Migration
  def self.up
    add_column :student_discipline_cases, :counselor_feedback, :text
  end

  def self.down
    remove_column :student_discipline_cases, :counselor_feedback
  end
end
