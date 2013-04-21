class AddColumnToExammark < ActiveRecord::Migration
  def self.up
    add_column :exammarks, :total_mcq, :decimal
  end

  def self.down
    remove_column :exammarks, :total_mcq
  end
end
