class CreateStaffAttendances < ActiveRecord::Migration
  def self.up
    create_table :staff_attendances do |t|
      t.integer :thumb_id
      t.datetime :logged_at
      t.string :log_type
      t.string :reason
      t.boolean :trigger
      t.integer :approved_by
      t.boolean :is_approved
      t.date :approved_on

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_attendances
  end
end
