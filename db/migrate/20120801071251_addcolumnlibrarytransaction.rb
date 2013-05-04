class Addcolumnlibrarytransaction < ActiveRecord::Migration
  def self.up
	add_column :librarytransactions, :outside_borrower, :string
  end

  def self.down
    remove_column :librarytransactions, :outside_borrower, :string
  end
end
