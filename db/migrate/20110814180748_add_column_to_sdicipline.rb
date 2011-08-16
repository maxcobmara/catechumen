class AddColumnToSdicipline < ActiveRecord::Migration
  def self.up
    add_column :sdiciplines, :infraction, :integer
  end

  def self.down
    remove_column :sdiciplines, :infraction
  end
end
