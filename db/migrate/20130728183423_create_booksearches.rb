class CreateBooksearches < ActiveRecord::Migration
  def self.up
    create_table :booksearches do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.string :accessionno
      t.timestamps
    end
  end

  def self.down
    drop_table :booksearches
  end
end
