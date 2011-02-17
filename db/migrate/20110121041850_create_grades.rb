class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.integer :student_id
      t.integer :subject_id
      t.boolean :sent_to_BPL
      t.date    :sent_date
      t.decimal :total_formative
      t.decimal :score
      t.boolean :eligible_for_exam
      t.boolean :carry_paper
      t.decimal :total_summative
      t.boolean :resit
      t.decimal :total_marks
      t.integer :grading_id

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
