class CreateBookingfacilities < ActiveRecord::Migration
  def self.up
    create_table :bookingfacilities do |t|
      t.integer :staff_id
      t.integer :location_id
      t.date    :requestdate
      t.datetime    :start_date
      t.datetime    :end_date
      t.boolean  :approval
      t.integer :approver_id
      t.date :approve_date
      t.timestamps
    end
  end

  def self.down
    drop_table :bookingfacilities
  end
end
