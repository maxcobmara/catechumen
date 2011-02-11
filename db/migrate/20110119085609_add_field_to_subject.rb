class AddFieldToSubject < ActiveRecord::Migration
  def self.up
     add_column :subjects, :credit, :integer
     add_column :subjects, :status, :integer
  end

  def self.down
    remove_column :subjects, :credit
    remove_column :subjects, :status
  end
end
