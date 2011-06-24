class AddColumnAuthnameToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :authname, :string
  end

  def self.down
    remove_column :roles, :authname
  end
end
