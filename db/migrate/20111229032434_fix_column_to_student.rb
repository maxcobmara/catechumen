class FixColumnToStudent < ActiveRecord::Migration
  def self.up
    remove_column :students, :photo_file_name
    remove_column :students, :photo_content_type
    remove_column :students, :photo_file_size
    remove_column :students, :photo_updated_at
    
    #change columnname
    rename_column :students, :matrixno,  :statecd
    rename_column :students, :offer_letter_serial,  :religion
    rename_column :students, :physical,  :pangkat
    rename_column :students, :allergy,   :unit
    rename_column :students, :disease,   :phoneoffice
    rename_column :students, :medication,   :phonehome
    rename_column :students, :group_id,   :approve_id
    
   
  end

  def self.down
    add_column :students, :photo_file_name, :string
    add_column :students, :photo_content_type, :string
    add_column :students, :photo_file_size, :integer
    add_column :students, :photo_updated_at, :datetime
  end
end
