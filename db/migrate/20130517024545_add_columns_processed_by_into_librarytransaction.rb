class AddColumnsProcessedByIntoLibrarytransaction < ActiveRecord::Migration
  def self.up
    add_column :librarytransactions, :libcheckout_by, :integer
    add_column :librarytransactions, :libextended_by, :integer
    add_column :librarytransactions, :libreturned_by, :integer
  end

  def self.down
    remove_column :librarytransactions, :libcheckout_by
    remove_column :librarytransactions, :libextended_by
    remove_column :librarytransactions, :libreturned_by
  end
end
