class CreateUsesupplies < ActiveRecord::Migration
  def self.up
    create_table :usesupplies do |t|
      t.integer :supplies_id
      t.integer :issuedby
      t.integer :receivedby
      t.decimal :quantity
      t.date    :issuedate

      t.timestamps
    end
  end

  def self.down
    drop_table :usesupplies
  end
end
