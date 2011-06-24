class AddColoumnToStaffcourse < ActiveRecord::Migration
  def self.up
    add_column :staffcourses, :description, :text
  end

  def self.down
    remove_column :staffcourses, :description
  end
end
