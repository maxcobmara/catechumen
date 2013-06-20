class CreateExamanalyses < ActiveRecord::Migration
  def self.up
    create_table :examanalyses do |t|
      t.integer :exam_id
      t.integer :gradeA
      t.integer :gradeAminus
      t.integer :gradeBplus
      t.integer :gradeB
      t.integer :gradeBminus
      t.integer :gradeCplus
      t.integer :gradeC
      t.integer :gradeCminus
      t.integer :gradeDplus
      t.integer :gradeD
      t.integer :gradeE

      t.timestamps
    end
  end

  def self.down
    drop_table :examanalyses
  end
end
