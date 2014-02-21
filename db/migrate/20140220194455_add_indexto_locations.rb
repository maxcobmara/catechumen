class AddIndextoLocations < ActiveRecord::Migration
  def self.up
    add_index :locations, :id
    add_index :locations, :combo_code
    add_index :tenants,   :id
    add_index :users,     :id
    add_index :students,  :id
    add_index :staffs,    :id
    add_index :accessions,:id
    add_index :accessions,:accession_no
    add_index :books,     :id
    add_index :books,     :isbn
  end

  def self.down
    remove_index :locations,  :id
    remove_index :locations,  :combo_code
    remove_index :tenants,    :id
    remove_index :users,      :id
    remove_index :students,   :id
    remove_index :staffs,     :id
    remove_index :accessions, :id
    remove_index :accessions, :accession_no
    remove_index :books,      :id
    remove_index :books,      :isbn
  end
end
