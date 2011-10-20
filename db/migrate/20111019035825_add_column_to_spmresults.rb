class AddColumnToSpmresults < ActiveRecord::Migration
  def self.up
    change_column :spmresults, :grade, :string
  end

  def self.down
    remove_column :spmresults, :grade
  end
end
