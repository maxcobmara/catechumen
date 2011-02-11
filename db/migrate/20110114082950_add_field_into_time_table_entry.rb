class AddFieldIntoTimeTableEntry < ActiveRecord::Migration
  def self.up
    add_column :time_table_entries, :period_timing_id, :integer
    add_column :time_table_entries, :residence_id, :integer
  end

  def self.down
    remove_column :time_table_entries, :period_timing_id
    remove_column :time_table_entries, :residence_id
  end
end
