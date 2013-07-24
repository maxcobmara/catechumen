class AddColumnsToDocumentsearch < ActiveRecord::Migration
  def self.up
    add_column :documentsearches, :sender, :string
  end

  def self.down
    remove_column :documentsearches, :sender
  end
end
