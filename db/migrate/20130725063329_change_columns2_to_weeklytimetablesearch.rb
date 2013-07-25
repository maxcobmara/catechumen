class ChangeColumns2ToWeeklytimetablesearch < ActiveRecord::Migration
  def self.up
    remove_column :weeklytimetablesearches, :intake
    add_column :weeklytimetablesearches, :intake, :integer
  end

  def self.down
    remove_column :weeklytimetablesearches, :intake
    add_column :weeklytimetablesearches, :intake, :date
  end
end
