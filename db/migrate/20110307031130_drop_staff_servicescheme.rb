class DropStaffServicescheme < ActiveRecord::Migration
  def self.up
    drop_table :staff_serviceschemes
  end

  def self.down
  end
end
