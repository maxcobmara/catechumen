class AddColumns4ToBooksearch < ActiveRecord::Migration
  def self.up
    add_column :booksearches, :accumbookloan, :integer
  end

  def self.down
    remove_column :booksearches, :accumbookloan
  end
end
