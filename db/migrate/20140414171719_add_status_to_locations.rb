class AddStatusToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :damaged, :boolean
    add_column :locations, :status, :string
  end

  def self.down
    remove_column :locations, :status
    remove_column :locations, :damaged
  end
end
