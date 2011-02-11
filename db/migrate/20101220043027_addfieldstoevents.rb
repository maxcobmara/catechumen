class Addfieldstoevents < ActiveRecord::Migration
  def self.up
     add_column :events, :eventstdt, :datetime
     add_column :events, :eventendt, :datetime
     
  end

  def self.down
    remove_column :events, :eventstdt
    remove_column :events, :eventendt
  end
end
