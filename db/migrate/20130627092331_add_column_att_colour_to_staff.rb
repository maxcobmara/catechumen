class AddColumnAttColourToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :att_colour, :integer
  end

  def self.down
    remove_column :staffs, :att_colour
  end
end
