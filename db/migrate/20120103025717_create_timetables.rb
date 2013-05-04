class CreateTimetables < ActiveRecord::Migration
  def self.up
    create_table :timetables do |t|
      t.integer :klass_id
      t.integer :topic_id
      t.integer :location_id
      t.integer :staff_id
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end

  def self.down
    drop_table :timetables
  end
end
