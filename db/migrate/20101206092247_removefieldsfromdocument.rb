class Removefieldsfromdocument < ActiveRecord::Migration
  def self.up
     remove_column :documents, :file_name
      remove_column :documents, :content_type
      remove_column :documents, :file_size
      remove_column :documents, :file_updated_at
  end

  def self.down
    add_column :documents, :file_name, :string
    add_column :documents, :content_type, :string
    add_column :documents, :file_size, :integer
    add_column :documents, :file_updated_at, :datetime
  end
end
