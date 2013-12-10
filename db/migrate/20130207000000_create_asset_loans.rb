class CreateAssetLoans < ActiveRecord::Migration
  def self.up   
    create_table :asset_loans do |t|
      t.integer  :asset_id
      t.integer  :staff_id
      t.text     :reasons
      t.integer  :loaned_by
      t.boolean  :is_approved
      t.date     :approved_date
      t.date     :loaned_on
      t.date     :expected_on
      t.boolean  :is_returned
      t.date     :returned_on
      t.text     :remarks
      t.integer  :loan_officer
      t.integer  :hod
      t.date     :hod_date
      t.integer  :loantype
      t.integer  :received_officer
      t.timestamps
    end
    
    create_table :assettracks do |t|
      t.integer  :asset_id
      t.integer  :staff_id
      t.date     :reservationdate
      t.date     :use_startdate
      t.date     :use_enddate
      t.integer  :issuedby
      t.date     :issuedate
      t.date     :expectedreturndate
      t.integer  :returnedto
      t.date     :actualreturndate
      t.string   :remarks
      t.timestamps
    end
  end
  
  def self.down
  end
end

 