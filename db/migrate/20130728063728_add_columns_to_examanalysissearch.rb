class AddColumnsToExamanalysissearch < ActiveRecord::Migration
  def self.up
    add_column :examanalysissearches, :exampaper, :integer
  end

  def self.down
    remove_column :examanalysissearches, :exampaper
  end
end
