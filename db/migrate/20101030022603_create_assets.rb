class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string     :assetcode
      t.string     :cardno
      t.integer    :dept_id
      t.integer    :assettype
      t.boolean    :bookable
      t.string     :name
      t.string     :category
      t.string     :type
      t.integer    :manufacturer_id
      t.string     :model
      t.string     :serialno
      t.string     :location
      t.text       :otherinfo
      t.string     :orderno
      t.decimal    :purchaseprice
      t.date       :purchasedate
      t.date       :receiveddate
      t.integer    :receiver_id
      t.integer    :supplier_id
      t.integer    :assignedto_id
      t.integer    :location_id
      t.boolean    :locassigned
      t.integer    :status

      t.timestamps
    end
  end

  def self.down
    drop_table:assets
  end
end
