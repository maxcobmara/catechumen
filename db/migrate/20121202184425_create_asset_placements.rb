class CreateAssetPlacements < ActiveRecord::Migration
  def self.up
    create_table :asset_placements do |t|
      t.integer :asset_id
      t.integer :location_id
      t.integer :staff_id
      t.date :reg_on

      t.timestamps
    end
  end

  def self.down
    drop_table :asset_placements
  end
end
