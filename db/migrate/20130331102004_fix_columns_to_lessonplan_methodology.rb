class FixColumnsToLessonplanMethodology < ActiveRecord::Migration
  def self.up
    add_column :lessonplan_methodologies, :start_meth, :time
    add_column :lessonplan_methodologies, :end_meth, :time
    remove_column :lessonplan_methodologies, :period
  end

  def self.down
    remove_column :lessonplan_methodologies, :start_meth
    remove_column :lessonplan_methodologies, :end_meth
    add_column :lessonplan_methodologies, :period, :time
  end
end
