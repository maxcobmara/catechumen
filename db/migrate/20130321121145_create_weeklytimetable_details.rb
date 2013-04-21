class CreateWeeklytimetableDetails < ActiveRecord::Migration
  def self.up
    create_table :weeklytimetable_details do |t|
      t.integer :day
      t.integer :subject
      t.integer :topic
      t.integer :time_slot
      t.integer :lecturer_id
      t.integer :weeklytimetable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :weeklytimetable_details
  end
end
