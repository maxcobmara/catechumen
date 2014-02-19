class AddComboCodeToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :combo_code, :string
    add_column :locations, :ancestry_depth, :integer,  :default => 0
  end

  def self.down
    remove_column :locations, :ancestry_depth
    remove_column :locations, :combo_code
  end
end
