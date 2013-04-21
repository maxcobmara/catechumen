class CreateStaffShifts < ActiveRecord::Migration
  def self.up
    create_table :staff_shifts do |t|
      t.string :name
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_shifts
  end
end
