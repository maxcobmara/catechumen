class AddColumnsToExams < ActiveRecord::Migration
  def self.up
    add_column :exams, :starttime, :time
    add_column :exams, :endtime, :time
  end

  def self.down
    remove_column :exams, :endtime
    remove_column :exams, :starttime
  end
end
