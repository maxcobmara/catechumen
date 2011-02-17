class CreateAddsuppliers < ActiveRecord::Migration
  def self.up
    create_table :addsuppliers do |t|
      t.integer :supplier_id
      t.string  :lpono
      t.string  :document
      t.decimal :quantity
      t.decimal :unitcost
      t.date    :received

      t.timestamps
    end
  end

  def self.down
    drop_table :addsuppliers
  end
end
