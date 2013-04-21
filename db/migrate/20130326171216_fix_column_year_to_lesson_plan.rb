class FixColumnYearToLessonPlan < ActiveRecord::Migration
  def self.up
      remove_column :lesson_plans, :year
      add_column :lesson_plans, :year, :integer
  end

  def self.down
      add_column :lesson_plans, :year, :date
      remove_column :lesson_plans, :year
  end
end
