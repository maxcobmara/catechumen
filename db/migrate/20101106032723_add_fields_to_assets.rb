class AddFieldsToAssets < ActiveRecord::Migration
  def self.up
  add_column :assets, :assignedto_id, :integer #from staff
  add_column :assets, :location_id, :integer #from location
  add_column :assets, :locassigned, :boolean
  add_column :assets, :status, :integer
  end

  def self.down
  remove_column :assets, :assignedto_id
  remove_column :assets, :location_id
  remove_column :assets, :locassigned
  remove_column :assets, :status
  end
end
