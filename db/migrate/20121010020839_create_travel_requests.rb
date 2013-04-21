class CreateTravelRequests < ActiveRecord::Migration
  def self.up
    create_table :travel_requests do |t|
      t.integer   :staff_id
      t.integer   :document_id
      t.integer   :staff_course_conducted_id
      t.string    :destination
      t.datetime  :depart_at
      t.datetime  :return_at
      
      t.boolean   :own_car
      t.string    :own_car_notes
      t.boolean   :dept_car
      t.boolean   :others_car
      t.boolean   :taxi
      t.boolean   :bus
      t.boolean   :train
      t.boolean   :plane          
      t.boolean   :other
      t.string    :other_desc
                            
      t.boolean   :is_submitted
      t.date      :submitted_on
      t.integer   :replaced_by
      t.boolean   :mileage
      t.boolean   :mileage_replace
                  
      t.integer   :hod_id
      t.boolean   :hod_accept
      t.date      :hod_accept_on
      t.integer   :travel_claim_id
      
      t.boolean   :is_travel_log_complete
      t.decimal   :log_mileage
      t.decimal   :log_fare

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_requests
  end
end
