class CreateOfficeSupplies < ActiveRecord::Migration
  def self.up
    create_table :stationeries do |t|
      t.string   :code
      t.string   :category
      t.string   :unittype
      t.decimal  :maxquantity
      t.decimal  :minquantity
      t.timestamps
    end
    
    create_table :suppliers do |t|
      t.string   :supplycode
      t.string   :category
      t.string   :unittype
      t.decimal  :maxquantity
      t.decimal  :minquantity
      t.timestamps
    end
       
    create_table :addsuppliers do |t|
      t.integer  :supplier_id
      t.string   :lpono
      t.string   :document
      t.decimal  :quantity
      t.decimal  :unitcost
      t.date     :received
      t.timestamps
    end
    
    create_table :txsupplies do |t|
      t.integer  :part_id
      t.integer  :receiver_id
      t.decimal  :quantity
      t.date     :tdate
      t.text     :details
      
    end
    
    create_table :usesupplies do |t|
      t.integer  :supplier_id
      t.integer  :issuedby
      t.integer  :receivedby
      t.decimal  :quantity
      t.date     :issuedate
      t.timestamps
    end
  end
  
  def self.down
  end
end