class CreateTravelClaimMileageRates < ActiveRecord::Migration
  def self.up
    create_table :travel_claim_mileage_rates do |t|
      t.integer :km_low,  :precision => 6
      t.integer :km_high, :precision => 6
      t.decimal :a_group, :precision => 4, :scale => 2
      t.decimal :b_group, :precision => 4, :scale => 2
      t.decimal :c_group, :precision => 4, :scale => 2
      t.decimal :d_group, :precision => 4, :scale => 2
      t.decimal :e_group, :precision => 4, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_claim_mileage_rates
  end
end
