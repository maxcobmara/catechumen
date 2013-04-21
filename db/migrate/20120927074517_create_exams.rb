class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string  :name
      t.text    :description
      t.integer :created_by
      t.integer :course_id
      t.integer :subject_id
      t.integer :klass_id
      t.date    :exam_on
      t.integer :duration
      t.integer :full_marks
      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
