class Addcolumntocoach < ActiveRecord::Migration
  def self.up
    add_column :evaluate_coaches, :result, :integer
  end

  def self.down
    add_column :evaluate_coaches, :result, :integer
  end
end
