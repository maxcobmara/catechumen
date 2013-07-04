class CreateStudentAttendances < ActiveRecord::Migration
  def self.up
    create_table :student_attendances do |t|
      t.integer :student_id
      t.boolean :attend
      t.integer :weeklytimetable_details_id

      t.timestamps
    end
  end

  def self.down
    drop_table :student_attendances
  end
end
