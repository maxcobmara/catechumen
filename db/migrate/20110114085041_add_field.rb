class AddField < ActiveRecord::Migration
  def self.up
    add_column :time_table_entries, :timing_id, :integer
  end

  def self.down
     remove_column :time_table_entries, :timing_id
  end
end
