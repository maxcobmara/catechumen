class CreateExaminationAnalyses < ActiveRecord::Migration
  def self.up   
    create_table :examanalyses do |t|
      t.integer  :exam_id
      t.integer  :gradeA
      t.integer  :gradeAminus
      t.integer  :gradeBplus
      t.integer  :gradeB
      t.integer  :gradeBminus
      t.integer  :gradeCplus
      t.integer  :gradeC
      t.integer  :gradeCminus
      t.integer  :gradeDplus
      t.integer  :gradeD
      t.integer  :gradeE
      t.timestamps
    end

    create_table :examanalysissearches do |t|
      t.string   :examtype
      t.integer  :subject_id
      t.date     :examon
      t.integer  :exampaper
      t.integer  :programme_id
      t.timestamps
    end
    
    create_table :examquestionanalyses do |t|
      t.integer  :examquestion_id
      t.integer  :count
      t.decimal  :min
      t.decimal  :max
      t.decimal  :mean
      t.decimal  :sd_population
      t.integer  :pass_rate
      t.decimal  :pass_percentage
      t.integer  :mark0
      t.integer  :markless20
      t.integer  :markless50
      t.integer  :markless80
      t.integer  :markmore80
      t.integer  :examanalysis_id
      t.timestamps
    end
  end
  
  def self.down
  end
end

 