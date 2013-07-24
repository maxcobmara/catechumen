class CreateStudentattendancesearches < ActiveRecord::Migration
  def self.up
    create_table :studentattendancesearches do |t|
      t.integer :schedule_id
      t.integer :intake_id
      t.integer :student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :studentattendancesearches
  end
end
