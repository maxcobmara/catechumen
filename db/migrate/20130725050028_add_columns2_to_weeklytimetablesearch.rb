class AddColumns2ToWeeklytimetablesearch < ActiveRecord::Migration
  def self.up
    add_column :weeklytimetablesearches, :intake_id, :integer
  end

  def self.down
    remove_column :weeklytimetablesearches, :intake_id
  end
end
