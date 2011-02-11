class Addfieldstousers < ActiveRecord::Migration
  def self.up
     add_column :users, :isstaff, :boolean
  end

  def self.down
    remove_column :users, :isstaff
  end
end
