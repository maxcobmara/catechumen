class AddIndextoLocations < ActiveRecord::Migration
  def self.up
    add_index :locations, :id
    add_index :locations, :combo_code
    add_index :tenants,   :id
    add_index :user,      :id
    add_index :student,   :id
    add_index :staff,     :id
    add_index :accession, :id
    add_index :accession, :accession_no
    add_index :book,      :id
    add_index :book,      :isbn
    add_index :user,      :id    
  end

  def self.down
    remove_index :locations,  :id
    remove_index :locations,  :combo_code
    remove_index :tenants,    :id
    remove_index :user,       :id
    remove_index :student,    :id
    remove_index :staff,      :id
    remove_index :accession,  :id
    remove_index :accession,  :accession_no
    remove_index :book,       :id
    remove_index :book,       :isbn
    remove_index :user,       :id    
  end
end
