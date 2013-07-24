class ChangeColumnsToStudentattendancesearch < ActiveRecord::Migration
  def self.up
    remove_column :studentattendancesearches, :intake_id
    add_column :studentattendancesearches, :intake_id, :date
  end

  def self.down
    add_column :studentattendancesearches, :intake_id, :integer
    remove_column :studentattendancesearches, :intake_id
  end
end
