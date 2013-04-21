class AddColumnsToWeeklytimetableDetail < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetable_details, :day2, :integer
    add_column :weeklytimetable_details, :time_slot2, :integer
  end

  def self.down
    remove_column :weeklytimetable_details, :time_slot2
    remove_column :weeklytimetable_details, :day2
  end
end
