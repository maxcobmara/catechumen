class CreateStockcards < ActiveRecord::Migration
  def self.up
    create_table :stockcards do |t|
      t.integer :stock_id
      t.integer :supplier_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :stockcards
  end
end
