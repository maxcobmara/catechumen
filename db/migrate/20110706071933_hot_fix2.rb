class HotFix2 < ActiveRecord::Migration
  def self.up
    remove_column :assets,  :category
  end

  def self.down
  end
end
