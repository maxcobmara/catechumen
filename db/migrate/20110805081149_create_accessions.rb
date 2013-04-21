class CreateAccessions < ActiveRecord::Migration
  def self.up
    create_table :accessions do |t|
      t.integer :book_id
      t.string  :accession_no
      t.string  :order_no
      t.decimal :purchase_price
      t.date    :received
      t.integer :received_by
      t.integer :supplied_by

      t.timestamps
    end
  end

  def self.down
    drop_table :accessions
  end
end
