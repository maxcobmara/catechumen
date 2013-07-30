class AddColumnsToBooksearch < ActiveRecord::Migration
  def self.up
    add_column :booksearches, :classno, :string
  end

  def self.down
    remove_column :booksearches, :classno
  end
end
