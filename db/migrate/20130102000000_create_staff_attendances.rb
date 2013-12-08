class CreateStaffAttendances < ActiveRecord::Migration
  def self.up   
    create_table :attendances do |t|
      t.integer  :staff_id
      t.date     :attdate
      t.time     :time_in
      t.time     :time_out
      t.string   :reason
      t.integer  :approve_id
      t.boolean  :approvestatus
      t.timestamps
    end
    
    create_table :staff_attendances do |t|
      t.integer  :thumb_id
      t.datetime :logged_at
      t.string   :log_type
      t.string   :reason
      t.boolean  :trigger
      t.integer  :approved_by
      t.boolean  :is_approved
      t.date     :approved_on
      t.integer  :status
      t.string   :review
      t.timestamps
    end
    
    create_table :staff_shifts do |t|
      t.string   :name
      t.time     :start_at
      t.time     :end_at
      t.timestamps
    end
  end
  
  def self.down
  end
end

 