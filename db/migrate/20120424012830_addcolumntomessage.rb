class Addcolumntomessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :title, :string
    add_column :messages, :cc_id, :integer
  end

  def self.down
     remove_column :messages, :title
     remove_column :messages, :cc_id
    
  end
end
