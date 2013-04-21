class CreateBooleananswers < ActiveRecord::Migration
  def self.up
    create_table :booleananswers do |t|
      t.string :item
      t.boolean :answer
      t.integer :examquestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :booleananswers
  end
end
