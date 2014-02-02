class CreateMultipleIndexes < ActiveRecord::Migration
  def self.up       
    add_index :locations, :ancestry
    add_index :positions, :ancestry
    add_index :staffs,    :icno
    add_index :staffs,    :name
    add_index :students,  :icno
    add_index :students,  :name
    add_index :students,  :matrixno
  end
  
  def self.down
    remove_index :locations, :ancestry
    remove_index :positions, :ancestry
    remove_index :staffs,    :icno
    remove_index :staffs,    :name
    remove_index :students,  :icno
    remove_index :students,  :name
    remove_index :students,  :matrixno
  end
end