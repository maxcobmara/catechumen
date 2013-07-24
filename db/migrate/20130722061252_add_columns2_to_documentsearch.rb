class AddColumns2ToDocumentsearch < ActiveRecord::Migration
  def self.up
    add_column :documentsearches, :letterdtend, :date
    add_column :documentsearches, :letterxdtend, :date
  end

  def self.down
    remove_column :documentsearches, :letterxdtend
    remove_column :documentsearches, :letterdtend
  end
end
