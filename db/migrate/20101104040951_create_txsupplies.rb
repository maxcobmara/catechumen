class CreateTxsupplies < ActiveRecord::Migration
  def self.up
    create_table :txsupplies do |t|
      t.integer :part_id
      t.integer :receiver_id
      t.decimal :quantity
      t.date :tdate
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :txsupplies
  end
end
