class AddAncestryToResidences < ActiveRecord::Migration
  def self.up
    add_column :residences, :ancestry, :string
    add_index  :residences, :ancestry
    
  end

  def self.down
    remove_index  :residences, :ancestry
    remove_column :residences, :ancestry
  end
end
