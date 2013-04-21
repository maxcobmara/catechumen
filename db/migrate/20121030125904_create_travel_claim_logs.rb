class CreateTravelClaimLogs < ActiveRecord::Migration
  def self.up
    create_table :travel_claim_logs do |t|
      t.integer :travel_request_id
      t.date    :travel_on
      t.time    :start_at
      t.time    :finish_at
      t.string  :destination
      t.decimal :mileage
      t.decimal :km_money
      t.boolean :checker
      t.string  :checker_notes 

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_claim_logs
  end
end
