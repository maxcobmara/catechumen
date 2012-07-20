class AddColumnToExamquestions < ActiveRecord::Migration
  def self.up
    add_column :examquestions, :programme_id, :integer
    rename_column :examquestions, :curriculum_id,  :subject_id
  end

  def self.down
    rename_column :examquestions,  :subject_id, :curriculum_id
    remove_column :examquestions, :programme_id
  end
end
