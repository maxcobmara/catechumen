class AddColumnsToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :sender, :string
  end

  def self.down
    remove_column :documents, :sender
  end
end
