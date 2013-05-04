class CreateInstructors < ActiveRecord::Migration
  def self.up
    create_table :instructors do |t|
      t.integer :staff_id
      t.date :appraisaldate
      t.boolean :qcsent
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4
      t.integer :q5
      t.integer :q6
      t.integer :q7
      t.integer :q8
      t.integer :q9
      t.integer :q10
      
      t.integer :q11
      t.integer :q12
      t.integer :q13
      t.integer :q14
      t.integer :q15
      t.integer :q16
      t.integer :q17
      t.integer :q18
      t.integer :q19
      t.integer :q20
      
      t.integer :q21
      t.integer :q22
      t.integer :q23
      t.integer :q24
      t.integer :q25
      t.integer :q26
      t.integer :q27
      t.integer :q28
      t.integer :q29
      t.integer :q30
      
      t.integer :q31
      t.integer :q32
      t.integer :q33
      t.integer :q34
      t.integer :q35
      t.integer :q36
      t.integer :q37
      t.integer :q38
      t.integer :q39
      t.integer :q40
      
      t.integer :q41
      t.integer :q42
      t.integer :q43
      t.integer :q44
      t.integer :q45
      t.integer :q46
      t.integer :q47
      t.integer :q48
      t.integer :total_mark
      t.timestamps
    end
  end

  def self.down
    drop_table :instructors
  end
end
