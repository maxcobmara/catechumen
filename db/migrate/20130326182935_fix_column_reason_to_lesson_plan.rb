class FixColumnReasonToLessonPlan < ActiveRecord::Migration
  def self.up
      remove_column :lesson_plans, :reason
      add_column :lesson_plans, :reason, :text
  end

  def self.down
      add_column :lesson_plans, :reason, :string
      remove_column :lesson_plans, :reason
  end
end
