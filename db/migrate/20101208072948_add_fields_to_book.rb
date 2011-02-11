class AddFieldsToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :issn, :string
    add_column :books, :edition, :string
  end

  def self.down
    remove_column :books, :edition
    remove_column :books, :issn
  end
end
