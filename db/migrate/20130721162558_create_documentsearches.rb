class CreateDocumentsearches < ActiveRecord::Migration
  def self.up
    create_table :documentsearches do |t|
      t.string :refno
      t.integer :category
      t.string :title
      t.date :letterdt
      t.date :letterxdt
      t.string :from
      t.integer :file_id
      t.boolean :closed
      t.timestamps
    end
  end

  def self.down
    drop_table :documentsearches
  end
end
