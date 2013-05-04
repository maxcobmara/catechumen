class AddAttachmentsDocumentToDownload < ActiveRecord::Migration
  def self.up
    add_column :downloads, :document_file_name, :string
    add_column :downloads, :document_content_type, :string
    add_column :downloads, :document_file_size, :integer
    add_column :downloads, :document_updated_at, :datetime
    
    add_column :downloads, :doc_name, :string
    add_column :downloads, :staff_id, :integer
    add_column :downloads, :doc_group, :string
    add_column :downloads, :upload_date, :date
  end

  def self.down
    remove_column :downloads, :document_file_name
    remove_column :downloads, :document_content_type
    remove_column :downloads, :document_file_size
    remove_column :downloads, :document_updated_at
    
    remove_column :downloads, :doc_name
    remove_column :downloads, :staff_id
    remove_column :downloads, :doc_group
    remove_column :downloads, :upload_date
  end
end
