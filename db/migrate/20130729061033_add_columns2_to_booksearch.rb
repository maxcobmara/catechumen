class AddColumns2ToBooksearch < ActiveRecord::Migration
  def self.up
    add_column :booksearches, :accessionno_start, :string
    add_column :booksearches, :accessionno_end, :string
  end

  def self.down
    remove_column :booksearches, :accessionno_end
    remove_column :booksearches, :accessionno_start
  end
end
