class Fixcolumnstudentinfo < ActiveRecord::Migration
  def self.up
      remove_column :students, :photo_file_name
      remove_column :students, :photo_content_type
      remove_column :students, :photo_file_size
      remove_column :students, :photo_updated_at
      
      add_column :students, :accomodation, :boolean
      add_column :students, :dish, :boolean
  end

  def self.down
    add_column :students, :photo_file_name
    add_column :students, :photo_content_type
    add_column :students, :photo_file_size
    add_column :students, :photo_updated_at
    
    remove_column :students, :accomodation
    remove_column :students, :dish
  end
end
