class AddColumns3ToStudentsearch < ActiveRecord::Migration
  def self.up
    add_column :studentsearches, :end_training2, :date
  end

  def self.down
    remove_column :studentsearches, :end_training2
  end
end
