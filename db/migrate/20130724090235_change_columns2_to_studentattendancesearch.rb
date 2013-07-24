class ChangeColumns2ToStudentattendancesearch < ActiveRecord::Migration
  def self.up
    remove_column :studentattendancesearches, :student_id
    add_column :studentattendancesearches, :student_id, :string
  end

  def self.down
    add_column :studentattendancesearches, :student_id, :integer
    remove_column :studentattendancesearches, :student_id
  end
end
