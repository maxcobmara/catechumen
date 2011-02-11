class RemoveFieldFromSubject < ActiveRecord::Migration
  def self.up
    remove_column :subjects, :description
  end

  def self.down
    add_column :subjects, :description, :string
  end
end
