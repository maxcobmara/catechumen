class CreateIndividuCourses < ActiveRecord::Migration
  def self.up
    create_table :individu_courses do |t|
      t.integer :staff_id
      t.string  :course_name
      t.date    :start_course
      t.date    :end_course
      t.string  :loc_course
      t.timestamps
    end
  end

  def self.down
    drop_table :individu_courses
  end
end
