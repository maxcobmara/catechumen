class AddFieldToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :specialisation, :string
  end

  def self.down
    remove_column :students, :specialisation
  end
end
