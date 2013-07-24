class AddColumnsToStudentsearch < ActiveRecord::Migration
  def self.up
    add_column :studentsearches, :gender, :integer
    add_column :studentsearches, :race, :string
    add_column :studentsearches, :bloodtype, :string
  end

  def self.down
    remove_column :studentsearches, :bloodtype
    remove_column :studentsearches, :race
    remove_column :studentsearches, :gender
  end
end
