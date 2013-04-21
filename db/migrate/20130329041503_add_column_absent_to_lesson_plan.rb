class AddColumnAbsentToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :total_absent, :integer
  end

  def self.down
    remove_column :lesson_plans, :total_absent
  end
end
