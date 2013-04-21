class CreateLessonplanMethodologies < ActiveRecord::Migration
  def self.up
    create_table :lessonplan_methodologies do |t|
      t.time :period
      t.text :content
      t.text :lecturer_activity
      t.text :student_activity
      t.text :training_aids
      t.text :evaluation

      t.timestamps
    end
  end

  def self.down
    drop_table :lessonplan_methodologies
  end
end
