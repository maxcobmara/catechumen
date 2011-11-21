class Renamecolumnevents < ActiveRecord::Migration
  def self.up
      rename_column :events, :eventstdt,  :start_at
      rename_column :events, :eventendt,  :end_at
      
  end

  def self.down
     rename_column :events, :start_at,  :eventstdt
     rename_column :events, :end_at,  :eventendt
  end
end
