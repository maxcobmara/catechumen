class CreateBulletins < ActiveRecord::Migration
  def self.up
    create_table :bulletins do |t|
      t.string  :headline
      t.text    :content
      t.integer :postedby_id
      t.date    :publishdt
      
      #columns for attachements
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :bulletins
  end
end
