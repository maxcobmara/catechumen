class CreateTravelClaims < ActiveRecord::Migration
  def self.up
    create_table :travel_claims do |t|
      t.integer :staff_id
      t.date    :claim_month
      t.decimal :advance
      t.decimal :total
      t.boolean :is_submitted
      t.date    :submitted_on
      
      #finance check
      t.boolean :is_checked
      t.boolean :is_returned
      t.date    :checked_on
      t.integer :checked_by
      t.string  :notes
      
      #finance check
      t.boolean :is_approved
      t.date    :approved_on
      t.integer :approved_by 

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_claims
  end
end
