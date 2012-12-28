class DropUnusedTables < ActiveRecord::Migration
  def self.up
    drop_table :travelrequests
    drop_table :travelclaims
  end

  def self.down
  end
end
