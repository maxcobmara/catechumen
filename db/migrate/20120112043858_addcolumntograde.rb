class Addcolumntograde < ActiveRecord::Migration
  def self.up
    add_column :grades, :typetest, :string
   # add_column :grades, :description, :string
   # add_column :grades, :mark, :integer
  #  add_column :grades, :totalmark, :integer
    
    
    rename_column :grades, :sent_to_BPL,  :sent_to_KM
  end

  def self.down
   # remove_column :grades, :type, :string
   # remove_column :grades, :description, :string
   # remove_column :grades, :mark, :integer
   # remove_column :grades, :totalmark, :integer
    
    rename_column :grades, :sent_to_KM,  :sent_to_BPL
    
  end
end
