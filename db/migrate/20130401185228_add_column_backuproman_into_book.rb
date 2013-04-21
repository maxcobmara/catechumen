class AddColumnBackupromanIntoBook < ActiveRecord::Migration
  def self.up
     add_column :books, :backuproman, :string
  end

  def self.down
    remove_column :books, :backuproman
  end
end
