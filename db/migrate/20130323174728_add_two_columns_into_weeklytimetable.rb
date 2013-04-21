class AddTwoColumnsIntoWeeklytimetable < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetables, :method, :integer
    add_column :weeklytimetables, :location, :integer
  end

  def self.down
    remove_column :weeklytimetables, :method
    remove_column :weeklytimetables, :location
  end
end
