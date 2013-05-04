class CreateStudentattendances < ActiveRecord::Migration
  def self.up
    create_table :studentattendances do |t|
      t.integer :timetable_id
      t.integer :student_id
      t.boolean :attend
      t.timestamps
    end
  end

  def self.down
    drop_table :studentattendances
  end
end
