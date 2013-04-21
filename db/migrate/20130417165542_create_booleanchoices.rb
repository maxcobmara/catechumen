class CreateBooleanchoices < ActiveRecord::Migration
  def self.up
    create_table :booleanchoices do |t|
      t.string :item
      t.string :description
      t.integer :examquestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :booleanchoices
  end
end
