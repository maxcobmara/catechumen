class CreateTimeTableEntries < ActiveRecord::Migration
  def self.up
    create_table :time_table_entries do |t|
      t.integer :intake_id
      t.integer :programme_id
      t.integer :subject_id
      t.integer :topic_id
      t.integer :timing_id
      t.integer :klass_id
      t.integer :timetable_week_day
      t.date    :timetable_date
      t.integer :staff_id
      t.integer :location_id
      t.integer :period_timing_id
      t.integer :residence_id

      t.timestamps
    end
  end

  def self.down
    drop_table :time_table_entries
  end
end
