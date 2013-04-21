class AddColumnToExamresult < ActiveRecord::Migration
  def self.up
    add_column :examresults, :examdts, :date
    add_column :examresults, :examdte, :date
  end

  def self.down
    remove_column :examresults, :examdts
    remove_column :examresults, :examdte
  end
end
