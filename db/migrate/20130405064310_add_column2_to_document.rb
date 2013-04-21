class AddColumn2ToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :prepared_by, :integer
  end

  def self.down
    remove_column :documents, :prepared_by
  end
end
