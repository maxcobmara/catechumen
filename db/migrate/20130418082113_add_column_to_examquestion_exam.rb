class AddColumnToExamquestionExam < ActiveRecord::Migration
  def self.up
    add_column :examquestions_exams, :sequence, :integer
  end

  def self.down
    remove_column :examquestions_exams, :sequence
  end
end
