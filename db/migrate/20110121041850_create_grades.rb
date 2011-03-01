class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.integer :student_id
      t.integer :subject_id
      t.boolean :sent_to_BPL
      t.date    :sent_date
      t.decimal :formative
      t.decimal :score
      t.boolean :eligible_for_exam
      t.boolean :carry_paper
      t.decimal :summative
      t.boolean :resit
      t.decimal :finalscore
      t.integer :grading_id
      
      t.string  :exam1name
      t.string  :exam1desc
      t.decimal :exam1marks
      t.string  :exam2name
      t.string  :exam2desc
      t.decimal :exam2marks
      t.decimal :examweight

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end



