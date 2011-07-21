class FixTypeInLocation < ActiveRecord::Migration
  def self.up
    rename_column :locations, :type,  :typename
  end

  def self.down
    rename_column :locations, :typename,  :type
  end
end
