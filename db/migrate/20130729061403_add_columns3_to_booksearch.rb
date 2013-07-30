class AddColumns3ToBooksearch < ActiveRecord::Migration
  def self.up
    add_column :booksearches, :stock_summary, :integer
  end

  def self.down
    remove_column :booksearches, :stock_summary
  end
end
