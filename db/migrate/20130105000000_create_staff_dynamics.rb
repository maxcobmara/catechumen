class CreateStaffDynamics < ActiveRecord::Migration
  def self.up       
    create_table :leaveforstaffs do |t|
      t.integer  :staff_id
      t.integer  :leavetype
      t.date     :leavestartdate
      t.date     :leavenddate
      t.decimal  :leavedays
      t.string   :reason
      t.text     :notes
      t.integer  :replacement_id
      t.boolean  :submit
      t.boolean  :approval1
      t.integer  :approval1_id
      t.date     :approval1date
      t.boolean  :approver2
      t.integer  :approval2_id
      t.date     :approval2date
      t.timestamps
    end
    
    create_table :travel_claim_allowances do |t|
      t.integer  :travel_claim_id
      t.integer  :expenditure_type
      t.string   :receipt_code
      t.date     :spent_on
      t.decimal  :amount
      t.decimal  :quantity
      t.boolean  :checker
      t.string   :checker_notes
      t.decimal  :total
      t.timestamps
    end

    create_table :travel_claim_logs do |t|
      t.integer  :travel_request_id
      t.date     :travel_on
      t.time     :start_at
      t.time     :finish_at
      t.string   :destination
      t.decimal  :mileage
      t.decimal  :km_money
      t.boolean  :checker
      t.string   :checker_notes
      t.timestamps
    end

    create_table :travel_claim_mileage_rates do |t|
      t.integer  :km_low
      t.integer  :km_high
      t.decimal  :a_group,    :precision => 4, :scale => 2
      t.decimal  :b_group,    :precision => 4, :scale => 2
      t.decimal  :c_group,    :precision => 4, :scale => 2
      t.decimal  :d_group,    :precision => 4, :scale => 2
      t.decimal  :e_group,    :precision => 4, :scale => 2
      t.timestamps
    end

    create_table :travel_claim_receipts do |t|
      t.integer  :travel_claim_id
      t.integer  :expenditure_type
      t.string   :receipt_code
      t.date     :spent_on
      t.decimal  :amount
      t.decimal  :quantity
      t.boolean  :checker
      t.string   :checker_notes
      t.timestamps
    end

    create_table :travel_claims do |t|
      t.integer  :staff_id
      t.date     :claim_month
      t.decimal  :advance
      t.decimal  :total
      t.boolean  :is_submitted
      t.date     :submitted_on
      t.boolean  :is_checked
      t.boolean  :is_returned
      t.date     :checked_on
      t.integer  :checked_by
      t.string   :notes
      t.boolean  :is_approved
      t.date     :approved_on
      t.integer  :approved_by
      t.timestamps
    end

    create_table :travel_claims_transport_groups do |t|
      t.string   :group_name,  :limit => 2, :null => false
      t.decimal  :salary_low,               :precision => 8, :scale => 2
      t.decimal  :salary_high,              :precision => 8, :scale => 2
      t.integer  :cc_low
      t.integer  :cc_high
      t.timestamps
    end

    create_table :travel_requests do |t|
      t.integer  :staff_id
      t.integer  :document_id
      t.integer  :staff_course_conducted_id
      t.string   :destination
      t.datetime :depart_at
      t.datetime :return_at
      t.boolean  :own_car
      t.string   :own_car_notes
      t.boolean  :dept_car
      t.boolean  :others_car
      t.boolean  :taxi
      t.boolean  :bus
      t.boolean  :train
      t.boolean  :plane
      t.boolean  :other
      t.string   :other_desc
      t.boolean  :is_submitted
      t.date     :submitted_on
      t.integer  :replaced_by
      t.boolean  :mileage
      t.boolean  :mileage_replace
      t.integer  :hod_id
      t.boolean  :hod_accept
      t.date     :hod_accept_on
      t.integer  :travel_claim_id
      t.boolean  :is_travel_log_complete
      t.decimal  :log_mileage
      t.decimal  :log_fare
      t.timestamps
    end

    create_table :traveldetailreceipts do |t|
      t.integer  :traveldetail_id
      t.integer  :type_id
      t.string   :receiptnp
      t.decimal  :rvalue
      t.timestamps
    end

    create_table :traveldetails do |t|
      t.integer  :travelclaimrequest_id
      t.date     :travelday
      t.time     :departure
      t.time     :arrival
      t.text     :description
      t.decimal  :distance
      t.decimal  :fare
      t.decimal  :value
      t.boolean  :lodging
      t.boolean  :meals
      t.boolean  :dinner
      t.timestamps
    end
  end
  
  def self.down
  end
end

 