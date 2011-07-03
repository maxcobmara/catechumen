class CreateAssetcategories < ActiveRecord::Migration
  def self.up
    create_table :assetcategories do |t|
      t.integer :parent_id
      t.string :description
      t.integer :cattype_id

      t.timestamps
    end
  end

  def self.down
    drop_table :assetcategories
  end
end
