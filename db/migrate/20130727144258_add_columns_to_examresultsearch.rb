class AddColumnsToExamresultsearch < ActiveRecord::Migration
  def self.up
    add_column :examresultsearches, :semester, :string
    add_column :examresultsearches, :examdts, :date
    add_column :examresultsearches, :examdte, :date
  end

  def self.down
    remove_column :examresultsearches, :examdte
    remove_column :examresultsearches, :examdts
    remove_column :examresultsearches, :semester
  end
end
