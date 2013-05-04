class CreateLessonPlans < ActiveRecord::Migration
  def self.up
    create_table :lesson_plans do |t|
      t.integer :topic_id
      t.integer :timing
      t.string :objective
      t.text :task
      t.string :tool
      t.timestamps
    end
  end

  def self.down
    drop_table :lesson_plans
  end
end
