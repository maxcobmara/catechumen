class CreateAnswerchoices < ActiveRecord::Migration
  def self.up
    create_table :answerchoices do |t|
      t.string :item
      t.string :description
      t.integer :examquestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :answerchoices
  end
end
