class FixColumnsToLessonPlan < ActiveRecord::Migration
  def self.up
      remove_column :lesson_plans, :prerequisites
      remove_column :lesson_plans, :reason
      add_column :lesson_plans, :prerequisites, :string
      add_column :lesson_plans, :reason, :string
  end

  def self.down
      add_column :lesson_plans, :reason, :text
      add_column :lesson_plans, :prerequisites, :text
      remove_column :lesson_plans, :prerequisites
      remove_column :lesson_plans, :reason
  end
end
