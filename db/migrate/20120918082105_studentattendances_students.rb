class StudentattendancesStudents < ActiveRecord::Migration
  def self.up
     create_table :studentattendances_students, :id => false do |t|
        t.integer :studentattendance_id
        t.integer :student_id
        t.boolean :attend
        t.string  :reason
      end
  end

  def self.down
    drop_table :studentattendances_students
  end
end
