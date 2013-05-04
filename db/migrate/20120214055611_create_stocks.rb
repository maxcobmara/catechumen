class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      
      #applicant
      t.integer :app_no
      t.integer :supplier_id
      t.string :quantity_order
      t.integer :staff_id
      t.date :app_date
      t.boolean :received
      t.date :received_date
      
      #approver
      t.integer :approver_id
      t.string :quantity_approved
      t.string :balance_quantity
      t.string :remark
      t.date :approve_date
      t.boolean :approval
      
      #storeman
      t.integer :storeman_id
      t.string :parcel_no
      t.date :date_update
      t.boolean :sent
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stocks
  end
end
