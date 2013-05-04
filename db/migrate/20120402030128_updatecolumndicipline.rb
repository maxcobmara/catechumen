class Updatecolumndicipline < ActiveRecord::Migration
  def self.up
    add_column :sdiciplines, :warden_id, :integer
    add_column :sdiciplines, :mentor_id, :integer
    add_column :sdiciplines, :caunsellor_id, :integer
    add_column :sdiciplines, :commandant_id, :integer
    
    #rename column
    rename_column :sdiciplines, :bplsenddt,  :commandantdt
  
    
  end

  def self.down
  end
end
