class AddColumnEndorsedToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :endorsed_by, :integer
  end

  def self.down
    remove_column :lesson_plans, :endorsed_by
  end
end
