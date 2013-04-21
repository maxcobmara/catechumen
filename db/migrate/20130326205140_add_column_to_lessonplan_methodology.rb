class AddColumnToLessonplanMethodology < ActiveRecord::Migration
  def self.up
    add_column :lessonplan_methodologies, :lesson_plan_id, :integer
  end

  def self.down
    remove_column :lessonplan_methodologies, :lesson_plan_id
  end
end
