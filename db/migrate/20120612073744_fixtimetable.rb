class Fixtimetable < ActiveRecord::Migration
  def self.up
    change_column :timetables, :start_at, :date
  end

  def self.down
    change_column :timetables, :start_at, :datetime
  end
end
