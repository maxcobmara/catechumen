class AddColumnsToLibrarytransactionsearch < ActiveRecord::Migration
  def self.up
    add_column :librarytransactionsearches, :yearstat, :date
  end

  def self.down
    remove_column :librarytransactionsearches, :yearstat
  end
end
