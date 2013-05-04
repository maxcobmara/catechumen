class Addcolumnptdo < ActiveRecord::Migration
  def self.up
    add_column :ptdos, :approver_1, :integer
    add_column :ptdos, :remark_1,  :string
    add_column :ptdos, :approver_2, :integer
    add_column :ptdos, :remark_2, :string
  
  end

  def self.down
      remove_column :ptdos, :approver_1, :integer
      remove_cplimn :ptdos, :remark_1,  :string
      remove_column :ptdos, :approver_2, :integer
      remove_column :ptdos, :remark_2, :string
  end
end
