class AddColumns2ToStudentsearch < ActiveRecord::Migration
  def self.up
    add_column :studentsearches, :sstatus, :string
    remove_column :studentsearches, :status
  end

  def self.down
    add_column :studentsearches, :status, :string
    remove_column :studentsearches, :sstatus
  end
end
