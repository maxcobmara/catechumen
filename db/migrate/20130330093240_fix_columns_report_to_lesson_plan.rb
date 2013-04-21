class FixColumnsReportToLessonPlan < ActiveRecord::Migration
  def self.up
    remove_column :lesson_plans, :is_submit
    remove_column :lesson_plans, :is_submitted_on
    remove_column :lesson_plans, :hod_endorsed
    remove_column :lesson_plans, :hod_endorsed_on
    add_column :lesson_plans, :report_submit, :boolean
    add_column :lesson_plans, :report_submit_on, :date
    add_column :lesson_plans, :report_endorsed, :boolean
    add_column :lesson_plans, :report_endorsed_on, :date
    add_column :lesson_plans, :report_summary, :text
   
  end

  def self.down
    add_column :lesson_plans, :is_submit, :boolean
    add_column :lesson_plans, :is_submitted_on, :date
    add_column :lesson_plans, :hod_endorsed, :boolean
    add_column :lesson_plans, :hod_endorsed_on, :date
    remove_column :lesson_plans, :report_submit
    remove_column :lesson_plans, :report_submit_on
    remove_column :lesson_plans, :report_endorsed
    remove_column :lesson_plans, :report_endorsed_on
    remove_column :lesson_plans, :report_summary
  end
end
