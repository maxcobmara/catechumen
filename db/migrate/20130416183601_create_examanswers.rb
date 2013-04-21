class CreateExamanswers < ActiveRecord::Migration
  def self.up
    create_table :examanswers do |t|
      t.string :item
      t.string :answer_desc
      t.integer :examquestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :examanswers
  end
end
