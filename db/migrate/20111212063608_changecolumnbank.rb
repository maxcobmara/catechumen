class Changecolumnbank < ActiveRecord::Migration
  def self.up
    change_column :banks,   :long_name,    :string
    add_column    :banks,   :active,       :boolean
  end

  def self.down
    change_column :banks,   :long_name,    :string
    remove_column :banks,   :active 
  end
end
