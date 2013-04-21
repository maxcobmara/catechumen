class AddAttachmentsPhotoToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :photo_file_name, :string
    add_column :students, :photo_content_type, :string
    add_column :students, :photo_file_size, :integer
    add_column :students, :photo_updated_at, :datetime
    
    #Additional fields added in
    add_column :students, :address,           :text
    add_column :students, :address_posbasik,  :text
    add_column :students, :end_training,      :date
    
  end

  def self.down
    remove_column :students, :photo_file_name
    remove_column :students, :photo_content_type
    remove_column :students, :photo_file_size
    remove_column :students, :photo_updated_at
    
    remove_column :students, :address
    remove_column :students, :address_posbasik
    remove_column :students, :end_training
    
    
  end
end
