class CreateStationeries < ActiveRecord::Migration
  def self.up
    create_table :stationeries do |t|
      t.string  :code
      t.string  :category
      t.string  :unittype
      t.decimal :maxquantity
      t.decimal :minquantity
      t.timestamps
    end
  end

  def self.down
    drop_table :stationeries
  end
end
