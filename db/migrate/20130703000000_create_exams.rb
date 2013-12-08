class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :examresults do |t|
      t.integer  :programme_id
      t.decimal  :total
      t.decimal  :pngs17
      t.string   :status
      t.string   :remark
      t.string   :semester
      t.date     :examdts
      t.date     :examdte
      t.timestamps
    end
    
    create_table :exammarks do |t|
      t.integer  :student_id
      t.integer  :exam_id
      t.decimal  :total_mcq
      t.timestamps
    end

    create_table :examresults_students, :id => false do |t|
      t.integer :examresult_id
      t.integer :student_id
    end

    create_table :examresultsearches do |t|
      t.integer  :programme_id
      t.integer  :subject_id
      t.integer  :student_id
      t.string   :semester
      t.date     :examdts
      t.date     :examdte
      t.timestamps
    end
    
    create_table :grades do |t|
      t.integer  :student_id
      t.integer  :subject_id
      t.boolean  :sent_to_BPL
      t.date     :sent_date
      t.decimal  :formative
      t.decimal  :score
      t.boolean  :eligible_for_exam
      t.boolean  :carry_paper
      t.decimal  :summative
      t.boolean  :resit
      t.decimal  :finalscore
      t.integer  :grading_id
      t.string   :exam1name
      t.string   :exam1desc
      t.decimal  :exam1marks
      t.string   :exam2name
      t.string   :exam2desc
      t.decimal  :exam2marks
      t.decimal  :examweight
      t.timestamps
    end
    
    create_table :marks do |t|
      t.integer  :exammark_id
      t.decimal  :student_mark
      t.timestamps
    end
    
    create_table :resultlines do |t|
      t.decimal  :total
      t.decimal  :pngs17
      t.string   :status
      t.string   :remark
      t.integer  :examresult_id
      t.integer  :student_id
      t.decimal  :pngk
      t.timestamps
    end
    
    create_table :scores do |t|
      t.integer  :type_id
      t.string   :description
      t.decimal  :marks
      t.decimal  :weightage
      t.decimal  :score
      t.decimal  :completion
      t.boolean  :formative
      t.integer  :grade_id
      t.timestamps
    end
  end
  
  def self.down
  end
end

 