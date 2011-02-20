class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string  :supplycode
      t.string  :category
      t.string  :unittype
      t.decimal :maxquantity
      t.decimal :minquantity

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
