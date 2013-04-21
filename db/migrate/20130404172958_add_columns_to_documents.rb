class AddColumnsToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :dataaction_file_name, :string
    add_column :documents, :dataaction_content_type, :string
    add_column :documents, :dataaction_file_size, :integer
    add_column :documents, :dataaction_updated_at, :datetime
  end

  def self.down
    remove_column :documents, :dataaction_updated_at
    remove_column :documents, :dataaction_file_size
    remove_column :documents, :dataaction_content_type
    remove_column :documents, :dataaction_file_name
  end
end
