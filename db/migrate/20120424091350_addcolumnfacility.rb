class Addcolumnfacility < ActiveRecord::Migration
  def self.up
    add_column :bookingfacilities, :remark, :string
  end

  def self.down
    remove_column :bookingfacilities, :remark
  end
end
