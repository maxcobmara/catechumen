class CreateTravelClaimsTransportGroups < ActiveRecord::Migration
  def self.up
    create_table :travel_claims_transport_groups do |t|
      t.string  :group_name,  :limit => 2, :null => false
      t.decimal :salary_low,  :precision => 8, :scale => 2
      t.decimal :salary_high, :precision => 8, :scale => 2
      t.integer :cc_low,      :precision => 5
      t.integer :cc_high,     :precision => 5

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_claims_transport_groups
  end
end
