class AddColumnSequToExam < ActiveRecord::Migration
  def self.up
    add_column :exams, :sequ, :string
  end

  def self.down
    remove_column :exams, :sequ
  end
end
