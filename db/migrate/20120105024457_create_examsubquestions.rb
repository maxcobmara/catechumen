class CreateExamsubquestions < ActiveRecord::Migration
  def self.up
    create_table :examsubquestions do |t|
      t.integer :examquestion_id
          t.integer :parent_id
          t.string :sequence
          t.string :question
          t.string :classification
          t.integer :marks
          t.text :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :examsubquestions
  end
end
