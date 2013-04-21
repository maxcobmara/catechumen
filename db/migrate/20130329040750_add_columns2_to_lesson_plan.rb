class AddColumns2ToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :condition_isgood, :boolean
    add_column :lesson_plans, :condition_isnotgood, :boolean
    add_column :lesson_plans, :condition_desc, :string
    add_column :lesson_plans, :training_aids, :text
    add_column :lesson_plans, :summary, :text
    add_column :lesson_plans, :is_submit, :boolean
    add_column :lesson_plans, :is_submitted_on, :date
    add_column :lesson_plans, :hod_endorsed, :boolean
    add_column :lesson_plans, :hod_endorsed_on, :date
  end

  def self.down
    remove_column :lesson_plans, :hod_endorsed_on
    remove_column :lesson_plans, :hod_endorsed
    remove_column :lesson_plans, :is_submitted_on
    remove_column :lesson_plans, :is_submit
    remove_column :lesson_plans, :summary
    remove_column :lesson_plans, :training_aids
    remove_column :lesson_plans, :condition_desc
    remove_column :lesson_plans, :condition_isnotgood
    remove_column :lesson_plans, :condition_isgood
  end
end
