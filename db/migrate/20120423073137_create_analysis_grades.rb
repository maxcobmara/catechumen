class CreateAnalysisGrades < ActiveRecord::Migration
  def self.up
    create_table :analysis_grades do |t|
      t.integer :course_id
      t.integer :class_id
      t.string  :exam_name
      t.date    :exam_date
      t.integer :staff_id
      t.integer :student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :analysis_grades
  end
end
