class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :serialno
      t.string :refno
      t.integer :category
      t.string :title
      t.date :letterdt
      t.date :letterxdt
      t.string :from
      t.integer :stafffiled_id
      t.integer :file_id
      t.boolean :closed

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
