class AddColumnToStudent2 < ActiveRecord::Migration
  def self.up
    add_column :students, :race2, :integer
  end

  def self.down
    remove_column :students, :race2
  end
end
