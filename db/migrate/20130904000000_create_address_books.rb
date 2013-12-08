class CreateAddressBooks < ActiveRecord::Migration
  def change
    create_table :addbooks do |t|
      t.string   :name
      t.string   :phone
      t.string   :address
      t.string   :mail
      t.string   :web
      t.string   :fax
      t.string   :shortname
      t.timestamps
    end
    
    create_table :address_book_items do |t|
      t.integer  :address_book_id
      t.string   :item
      t.timestamps
    end
  end
  
  def self.down
  end
end