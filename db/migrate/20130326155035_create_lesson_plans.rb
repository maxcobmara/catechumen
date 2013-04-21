class CreateLessonPlans < ActiveRecord::Migration
  def self.up
    create_table :lesson_plans do |t|
      t.integer :lecturer
      t.integer :intake_id
      t.integer :student_qty
      t.date :year
      t.integer :semester
      t.integer :topic
      t.string :lecture_title
      t.date :lecture_date
      t.time :start_time
      t.time :end_time
      t.text :prerequisites
      t.text :reference
      t.boolean :is_submitted
      t.date :submitted_on
      t.boolean :hod_approved
      t.date :hod_approved_on
      t.boolean :hod_rejected
      t.date :hod_rejected_on
      t.text :reason
      t.integer :methodology_id
      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_plans
  end
end
