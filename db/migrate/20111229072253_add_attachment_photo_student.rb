class AddAttachmentPhotoStudent < ActiveRecord::Migration
  def self.up
    #photo upload
    add_column :students, :photo_file_name, :string
    add_column :students, :photo_content_type, :string
    add_column :students, :photo_file_size, :integer
    add_column :students, :photo_updated_at, :datetime
    
    #add field poskod
    add_column :students, :poskod, :string
    
    #change datatype
   # change_column :students,   :statecd,    :integer
   # change_column :students,   :religion,    :integer
    
    #rename column_name
    rename_column :students, :address_posbasik,  :office_address
    rename_column :students, :regdate,  :start_training
    
  end

  def self.down
    remove_column :students, :photo_file_name
    remove_column :students, :photo_content_type
    remove_column :students, :photo_file_size
    remove_column :students, :photo_updated_at
    
   
  end
end
