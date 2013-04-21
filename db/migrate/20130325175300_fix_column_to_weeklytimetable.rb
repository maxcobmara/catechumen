class FixColumnToWeeklytimetable < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetables, :reason, :string
    remove_column :weeklytimetables, :method
    remove_column :weeklytimetables, :location
  end

  def self.down
    add_column :weeklytimetables, :method, :integer
    add_column :weeklytimetables, :location, :integer
    remove_column :weeklytimetables, :reason
  end
end
