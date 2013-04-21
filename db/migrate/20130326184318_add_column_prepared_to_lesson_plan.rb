class AddColumnPreparedToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :prepared_by, :integer
  end

  def self.down
    remove_column :lesson_plans, :prepared_by
  end
end
