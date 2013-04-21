class CreateTimetablePeriods < ActiveRecord::Migration
  def self.up
    create_table :timetable_periods do |t|
      t.integer :timetable_id
      t.integer :sequence
      t.integer :day_name
      t.time :start_at
      t.time :end_at
      t.boolean :is_break

      t.timestamps
    end
  end

  def self.down
    drop_table :timetable_periods
  end
end
