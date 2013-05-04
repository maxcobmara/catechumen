class Addcolumnintoinstructor < ActiveRecord::Migration
  def self.up
     add_column :instructors, :check_qc, :integer
     add_column :instructors, :check_date, :date
     add_column :instructors, :checked, :boolean
  end

  def self.down
     remove_column :instructors, :check_qc
     remove_column :instructors, :check_date
     remove_column :instructors, :checked
  end
end
