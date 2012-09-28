class Rename < ActiveRecord::Migration
  def self.up
    rename_table  :exammakers_examquestions, :examquestions_exams
    rename_column :examquestions_exams, :exammaker_id, :exam_id
  end

  def self.down
    rename_column :examquestions_exams, :exam_id, :exammaker_id
    rename_table :examquestions_exams, :exammakers_examquestions
  end
end