class CreateAddressBookItems < ActiveRecord::Migration
  def self.up
    create_table :address_book_items do |t|
      t.integer :type_id
      t.integer :address_book_id
      t.string :item

      t.timestamps
    end
  end

  def self.down
    drop_table :address_book_items
  end
end
