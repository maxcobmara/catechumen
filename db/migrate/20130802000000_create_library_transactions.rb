class CreateLibraryTransactions < ActiveRecord::Migration
  def self.up   
    create_table :librarytransactions do |t|
      t.integer  :accession_id
      t.boolean  :ru_staff
      t.integer  :staff_id
      t.integer  :student_id
      t.date     :checkoutdate
      t.date     :returnduedate
      t.boolean  :extended
      t.boolean  :returned
      t.date     :returneddate
      t.decimal  :fine
      t.boolean  :finepay
      t.date     :finepaydate
      t.boolean  :reportlost
      t.text     :report
      t.date     :reportlostdate
      t.date     :replaceddate
      t.integer  :libcheckout_by
      t.integer  :libextended_by
      t.integer  :libreturned_by
      t.timestamps
    end

    create_table :librarytransactionsearches do |t|
      t.integer  :accumbookloan
      t.integer  :programme
      t.integer  :fines
      t.integer  :bookloans
      t.date     :yearstat
      t.integer  :details
      t.timestamps
    end
  end
  
  def self.down
  end
end

