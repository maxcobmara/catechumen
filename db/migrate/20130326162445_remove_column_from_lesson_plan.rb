class RemoveColumnFromLessonPlan < ActiveRecord::Migration
  def self.up
      remove_column :lesson_plans, :methodology_id
  end

  def self.down
      add_column :lesson_plans, :methodology_id, :integer
  end
end