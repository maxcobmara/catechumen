class Addcolumntostudent < ActiveRecord::Migration
  def self.up
    change_column :students,   :intake,    :string
    add_column    :students,   :vehicletype,  :integer
    add_column    :students,   :vehicleregno,  :string
  end

  def self.down
    change_column :students,   :intake,    :date
    remove_column :students,   :vehicletype
    remove_column :students,   :vehicleregno
  end
end
