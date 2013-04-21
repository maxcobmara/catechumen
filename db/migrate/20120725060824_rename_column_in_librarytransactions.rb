class RenameColumnInLibrarytransactions < ActiveRecord::Migration
  def self.up
    rename_column :librarytransactions, :book_id,  :accession_id
  end

  def self.down
    rename_column :librarytransactions,  :accession_id, :book_id
  end
end
