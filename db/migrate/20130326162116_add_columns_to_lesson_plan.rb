class AddColumnsToLessonPlan < ActiveRecord::Migration
  def self.up
    add_column :lesson_plans, :data_file_name, :string
    add_column :lesson_plans, :data_content_type, :string
    add_column :lesson_plans, :data_file_size, :integer
    add_column :lesson_plans, :data_updated_at, :datetime
  end

  def self.down
    remove_column :lesson_plans, :data_updated_at
    remove_column :lesson_plans, :data_file_size
    remove_column :lesson_plans, :data_content_type
    remove_column :lesson_plans, :data_file_name
  end
end
