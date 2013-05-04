class CreateClassroomStudentJoins < ActiveRecord::Migration
  def self.up
    create_table :classrooms_students do |t|
      t.integer :classroom_id
      t.integer :student_id
      t.integer :programme_id

      t.timestamps
    end
  end

  def self.down
    drop_table :classroom_students
  end
end
