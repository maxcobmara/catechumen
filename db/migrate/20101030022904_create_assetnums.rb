class CreateAssetnums < ActiveRecord::Migration
  def self.up
    create_table :assetnums do |t|
      t.integer :asset_id
      t.string :assetnumname
      t.string :assetadnum

      t.timestamps
    end
  end

  def self.down
    drop_table :assetnums
  end
end
