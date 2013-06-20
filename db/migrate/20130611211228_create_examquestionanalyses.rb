class CreateExamquestionanalyses < ActiveRecord::Migration
  def self.up
    create_table :examquestionanalyses do |t|
      t.integer :examquestion_id
      t.integer :count
      t.decimal :min
      t.decimal :max
      t.decimal :mean
      t.decimal :sd_population
      t.integer :pass_rate
      t.decimal :pass_percentage
      t.integer :mark0
      t.integer :markless20
      t.integer :markless50
      t.integer :markless80
      t.integer :markmore80
      t.integer :examanalysis_id

      t.timestamps
    end
  end

  def self.down
    drop_table :examquestionanalyses
  end
end
