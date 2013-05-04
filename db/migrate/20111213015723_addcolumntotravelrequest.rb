class Addcolumntotravelrequest < ActiveRecord::Migration
  def self.up
     add_column :travelrequests, :asset_id, :integer
     add_column :travelrequests, :fuelstart, :string
     add_column :travelrequests, :fuelend, :string
     add_column :travelrequests, :tngserialno, :string
     add_column :travelrequests, :tngbeforetakenout, :string
     add_column :travelrequests, :tngaftertakenout, :string
  end

  def self.down
    remove_column :travelrequests, :asset_id
    remove_column :travelrequests, :fuelstart
    remove_column :travelrequests, :fuelend
    remove_column :travelrequests, :tngserialno
    remove_column :travelrequests, :tngbeforetakenout
    remove_column :travelrequests, :tngaftertakenout
  end
end
