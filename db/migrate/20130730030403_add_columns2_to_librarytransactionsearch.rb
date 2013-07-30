class AddColumns2ToLibrarytransactionsearch < ActiveRecord::Migration
  def self.up
    add_column :librarytransactionsearches, :details, :integer
  end

  def self.down
    remove_column :librarytransactionsearches, :details
  end
end
