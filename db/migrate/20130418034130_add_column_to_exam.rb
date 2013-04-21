class AddColumnToExam < ActiveRecord::Migration
  def self.up
    add_column :exams, :topic_id, :integer
  end

  def self.down
    remove_column :exams, :topic_id
  end
end
