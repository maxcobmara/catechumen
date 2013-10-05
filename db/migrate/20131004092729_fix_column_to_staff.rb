class FixColumnToStaff < ActiveRecord::Migration
  def self.up
    remove_column :staffs, :phonehome
    add_column :staffs, :phonehome, :string
  end

  def self.down
    add_column :staffs, :phonehome, :boolean
    remove_column :staffs, :phonehome    
  end
end
