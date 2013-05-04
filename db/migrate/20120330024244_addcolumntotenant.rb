class Addcolumntotenant < ActiveRecord::Migration
  def self.up
    add_column :tenants, :lockerkey_received_date, :date
    add_column :tenants, :lockerkey_returned_date, :date
  end

  def self.down
  end
end
