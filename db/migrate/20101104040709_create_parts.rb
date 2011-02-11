class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.string :partcode
      t.string :category
      t.string :unittype
      t.decimal :quantity
      t.decimal :maxquantity
      t.decimal :minquantity
      t.integer :asset_id

      t.timestamps
    end
  end

  def self.down
    drop_table :parts
  end
end
