class CreateTravelRequests < ActiveRecord::Migration
  def self.up
    create_table :travel_requests do |t|
      t.integer :staff_id
      t.string  :request_code
      t.string  :destination
      t.string  :purpose
      t.datetime :depart_at
      t.datetime :return_at
      t.string  :transport_type
      t.boolean :train
      t.boolean :plane
      t.boolean :other
      t.string  :other_desc
      t.text    :own_car_notes
      t.boolean :mileage
      t.boolean :mileage_replace
      t.boolean :is_submitted
      t.date    :submitted_on
      t.integer :replaced_by
      t.integer :hod_id
      t.boolean :hod_accept
      t.date    :hod_accept_on
      t.integer :travelclaim_id

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_requests
  end
end
