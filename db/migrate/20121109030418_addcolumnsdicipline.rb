class Addcolumnsdicipline < ActiveRecord::Migration
  def self.up
    add_column :sdiciplines, :ru_staff, :boolean
  end

  def self.down
    remove_column :studentattendances, :programme_id
  end
end
