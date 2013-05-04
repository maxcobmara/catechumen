class CreateAnalysispaperexams < ActiveRecord::Migration
  def self.up
    create_table :analysispaperexams do |t|
      t.integer :course_id
      t.integer :class_id
      t.integer :exam_id
      t.date    :exam_date
      t.integer :student_id
      t.timestamps
    end
  end

  def self.down
    drop_table :analysispaperexams
  end
end
