class RenameColumnInLibrarytransaction < ActiveRecord::Migration
  def self.up
    remove_column :librarytransactions, :staff
    add_column :librarytransactions, :isitstaff, :boolean
  end

  def self.down
    add_column :librarytransactions, :staff, :boolean
    remove_column :librarytransactions, :isitstaff
  end
end
