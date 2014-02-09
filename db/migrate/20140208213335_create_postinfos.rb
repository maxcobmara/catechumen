class CreatePostinfos < ActiveRecord::Migration
  def self.up
    create_table :postinfos do |t|
      t.string :details
      t.integer :staffgrade_id
      t.integer :post_count

      t.timestamps
    end
  end

  def self.down
    drop_table :postinfos
  end
end
