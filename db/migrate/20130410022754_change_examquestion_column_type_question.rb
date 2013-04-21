class ChangeExamquestionColumnTypeQuestion < ActiveRecord::Migration
  def self.up
    change_column :examquestions, :question, :text
  end

  def self.down
    change_column :examquestions, :question, :string
  end
end
