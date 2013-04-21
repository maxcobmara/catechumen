class ChangeColumnToWeeklytimetableDetail < ActiveRecord::Migration
  def self.up
     add_column :weeklytimetable_details, :is_friday, :boolean
     remove_column :weeklytimetable_details, :day
   end

   def self.down
     remove_column :weeklytimetable_details, :is_friday
     add_column :weeklytimetable_details, :day, :integer
   end
end
