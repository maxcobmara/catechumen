class Dropfemalefromstaff < ActiveRecord::Migration
  def self.up
     remove_column :staffs, :female
  end

  def self.down
     add_column :staffs, :female, :boolean
  end
end
