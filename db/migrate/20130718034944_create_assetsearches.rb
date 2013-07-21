class CreateAssetsearches < ActiveRecord::Migration
  def self.up
    create_table :assetsearches do |t|
      t.string :assetcode
      t.integer :assettype
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :assetsearches
  end
end
