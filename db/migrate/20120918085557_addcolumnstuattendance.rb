class Addcolumnstuattendance < ActiveRecord::Migration
  def self.up
    add_column :studentattendances, :programme_id, :integer
  end

  def self.down
    remove_column :studentattendances, :programme_id
  end
end
