class Addcolumntabletenant < ActiveRecord::Migration
  def self.up
     add_column :tenants, :staff_id, :integer
     add_column :tenants, :student_id, :integer
     add_column :tenants, :keyaccept, :date
     add_column :tenants, :keyexpectedreturn, :date
     add_column :tenants, :keyreturned, :date
     add_column :tenants, :force_vacate, :boolean
     
     drop_table :tenantdetails
  end

  def self.down
  end
end
