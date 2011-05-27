class AddColumnsToStudents < ActiveRecord::Migration
  def self.up
    add_column  :students, :offer_letter_serial,  :string
    add_column  :students, :race,                 :string
  end

  def self.down
  end
end
