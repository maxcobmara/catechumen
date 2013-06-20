class AddColumnToResultline < ActiveRecord::Migration
  def self.up
    add_column :resultlines, :pngk, :decimal
  end

  def self.down
    remove_column :resultlines, :pngk
  end
end
