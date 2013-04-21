class CreateTravelClaimAllowances < ActiveRecord::Migration
  def self.up
    create_table :travel_claim_allowances do |t|
      t.integer :travel_claim_id
      t.integer :expenditure_type
      t.string :receipt_code
      t.date :spent_on
      t.decimal :amount
      t.decimal :quantity
      t.boolean :checker
      t.string :checker_notes
      t.decimal :total

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_claim_allowances
  end
end
