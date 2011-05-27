class ChangeInTte < ActiveRecord::Migration
  def self.up
    rename_column :time_table_entries, :timetable_week_day, :tt_wd
  end

  def self.down
  end
end
