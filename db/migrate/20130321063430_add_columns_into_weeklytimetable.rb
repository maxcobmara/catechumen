class AddColumnsIntoWeeklytimetable < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetables, :week, :integer
    add_column :weeklytimetables, :is_submitted, :boolean
    add_column :weeklytimetables, :submitted_on, :date
    add_column :weeklytimetables, :hod_approved, :boolean
    add_column :weeklytimetables, :hod_approved_on, :date
  end

  def self.down
    remove_column :weeklytimetables, :week
    remove_column :weeklytimetables, :is_submitted
    remove_column :weeklytimetables, :submitted_on
    remove_column :weeklytimetables, :hod_approved
    remove_column :weeklytimetables, :hod_approved_on
  end
end
