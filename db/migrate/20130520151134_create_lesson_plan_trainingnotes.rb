class CreateLessonPlanTrainingnotes < ActiveRecord::Migration
  def self.up
    create_table :lesson_plan_trainingnotes do |t|
      t.integer :lesson_plan_id
      t.integer :trainingnote_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_plan_trainingnotes
  end
end
