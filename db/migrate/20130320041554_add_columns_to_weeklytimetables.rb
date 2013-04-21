class AddColumnsToWeeklytimetables < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetables, :format1, :integer
    add_column :weeklytimetables, :format2, :integer
  end

  def self.down
    remove_column :weeklytimetables, :format2
    remove_column :weeklytimetables, :format1
  end
end
