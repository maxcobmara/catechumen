class Addgendertostaff < ActiveRecord::Migration
  def self.up
     add_column :staffs, :gender, :integer 
  end

  def self.down
     remove_column :staffs, :gender
  end
end
