class AddColumnToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :icno, :string
  end

  def self.down
    remove_column :users, :icno
  end
end
