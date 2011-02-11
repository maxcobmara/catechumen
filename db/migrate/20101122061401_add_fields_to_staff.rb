class AddFieldsToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :race,      :integer
    add_column :staffs, :religion,  :integer
    add_column :staffs, :female,    :boolean
    add_column :staffs, :phonecell, :string
    add_column :staffs, :phonehome, :boolean
  end

  def self.down
    remove_column :staffs, :race
    remove_column :staffs, :religion
    remove_column :staffs, :female
    remove_column :staffs, :phonecell
    remove_column :staffs, :phonehome
  end
end
