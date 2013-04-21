class AddColumnScheduleToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :schedule, :integer
  end

  def self.down
    remove_column :lesson_plans, :schedule
  end
end
