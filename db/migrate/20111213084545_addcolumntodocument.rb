class Addcolumntodocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :classification, :integer
  end

  def self.down
    remove_column :documents, :classification
  end
end
