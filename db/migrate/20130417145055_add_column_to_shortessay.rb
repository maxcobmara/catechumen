class AddColumnToShortessay < ActiveRecord::Migration
  def self.up
    add_column :shortessays, :keyword, :string
  end

  def self.down
    remove_column :shortessays, :keyword
  end
end
