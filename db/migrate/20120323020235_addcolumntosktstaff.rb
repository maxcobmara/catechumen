class Addcolumntosktstaff < ActiveRecord::Migration
  def self.up
    add_column :skt_staffs, :ppp_id, :integer
    
  end

  def self.down
    remove_column :skt_staffs, :ppp_id, :integer
  end
end
