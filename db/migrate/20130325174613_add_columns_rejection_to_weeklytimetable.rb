class AddColumnsRejectionToWeeklytimetable < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetables, :hod_rejected, :boolean
    add_column :weeklytimetables, :hod_rejected_on, :date
  end

  def self.down
    remove_column :weeklytimetables, :hod_rejected_on
    remove_column :weeklytimetables, :hod_rejected
  end
end
