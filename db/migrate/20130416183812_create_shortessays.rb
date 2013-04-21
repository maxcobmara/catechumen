class CreateShortessays < ActiveRecord::Migration
  def self.up
    create_table :shortessays do |t|
      t.string :item
      t.string :subquestion
      t.decimal :submark
      t.text :subanswer
      t.integer :examquestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :shortessays
  end
end
