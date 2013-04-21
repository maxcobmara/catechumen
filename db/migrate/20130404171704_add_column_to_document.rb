class AddColumnToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :cc1actiondate, :date
  end

  def self.down
    remove_column :documents, :cc1actiondate
  end
end
