class CreateBankaccounts < ActiveRecord::Migration
  def self.up
     create_table :bankaccounts do |t|
       t.integer :staff_id
       t.integer :student_id
       t.integer :bank_id
       t.string :account_no
       t.integer :account_type

       t.timestamps
     end
   end

   def self.down
     drop_table :bankaccounts
   end
end
