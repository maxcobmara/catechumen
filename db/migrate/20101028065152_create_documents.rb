class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string   :serialno
      t.string   :refno
      t.integer  :category
      t.string   :title
      t.date     :letterdt
      t.date     :letterxdt
      t.string   :from
      t.integer  :stafffiled_id
      t.integer  :file_id
      t.boolean  :closed
      
      #segment for document attachment.
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
