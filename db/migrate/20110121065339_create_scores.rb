class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :type_id
      t.string  :description
      t.decimal :marks
      t.decimal :weightage
      t.decimal :score
      t.decimal :completion
      t.boolean :formative

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
