class Fixtravelrequest < ActiveRecord::Migration
  def self.up
    add_column :travelrequests, :hod_approved, :boolean
    add_column :travelrequests, :transport_travel, :integer
  end

  def self.down
    add_column :travelrequests, :hod_approved, :boolean
    add_column :travelrequests, :transport_travel, :integer
  end
end
