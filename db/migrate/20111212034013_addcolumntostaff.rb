class Addcolumntostaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :vehicleregno, :string
  end

  def self.down
    remove_column :staffs, :vehicleregno
  end
end
