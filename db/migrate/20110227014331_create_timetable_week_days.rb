class CreateTimetableWeekDays < ActiveRecord::Migration
  def self.up
    create_table :timetable_week_days do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :timetable_week_days
  end
end
