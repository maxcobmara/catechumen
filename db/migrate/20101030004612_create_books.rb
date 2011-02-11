class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :tagno
      t.string :controlno
      t.string :isbn
      t.string :bookcode
      t.string :accessionno
      t.string :catsource
      t.string :classlcc
      t.string :classddc
      t.string :title
      t.string :author
      t.string :publisher
      t.string :description
      t.integer :loantype
      t.integer :mediatype
      t.integer :status
      t.string :series
      t.string :location
      t.string :topic
      t.string :orderno
      t.decimal :purchaseprice,
      :precision => 8, :scale => 2, :default => 0
      t.date :purchasedate
      t.date :receiveddate
      t.integer :receiver_id
      t.integer :supplier_id

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
