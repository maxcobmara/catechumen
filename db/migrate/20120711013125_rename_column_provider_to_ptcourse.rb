class RenameColumnProviderToPtcourse < ActiveRecord::Migration
  def self.up
      #rename_column :ptcourses, :provider,  :provider_id     
  end

  def self.down
     #rename_column :ptcourses, :provider_id ,  :provider
  end
end
