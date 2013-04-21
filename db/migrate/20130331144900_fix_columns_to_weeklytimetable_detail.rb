class FixColumnsToWeeklytimetableDetail < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetable_details, :lecture_method, :integer
    remove_column :weeklytimetable_details, :method
  end
  def self.down
    remove_column :weeklytimetable_details, :lecture_method
    add_column :weeklytimetable_details, :method, :integer
  end
end
