class CreateExaminationDevelopments < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.string   :name
      t.text     :description
      t.integer  :created_by
      t.integer  :course_id
      t.integer  :subject_id
      t.integer  :klass_id
      t.date     :exam_on
      t.integer  :duration
      t.integer  :full_marks
      t.time     :starttime
      t.time     :endtime
      t.integer  :topic_id
      t.string   :sequ
      t.timestamps
    end
    
    create_table :examtemplates do |t|
      t.integer  :quantity
      t.integer  :exam_id
      t.decimal  :total_marks
      t.string   :questiontype
      t.timestamps
    end
    
    create_table :examquestions_exams, :id => false do |t|
      t.integer  :exam_id
      t.integer  :examquestion_id
      t.integer  :sequence
      t.timestamps
    end
    
    
    create_table :examquestions do |t|
      t.integer  :subject_id
      t.string   :questiontype
      t.text     :question
      t.text     :answer
      t.decimal  :marks
      t.string   :category
      t.string   :qkeyword
      t.string   :qstatus
      t.integer  :creator_id
      t.date     :createdt
      t.string   :difficulty
      t.text     :statusremark
      t.integer  :editor_id
      t.date     :editdt
      t.integer  :approver_id
      t.date     :approvedt
      t.boolean  :bplreserve
      t.boolean  :bplsent
      t.date     :bplsentdt
      t.string   :diagram_file_name
      t.string   :diagram_content_type
      t.integer  :diagram_file_size
      t.datetime :diagram_updated_at
      t.integer  :topic_id
      t.string   :construct
      t.boolean  :conform_curriculum
      t.boolean  :conform_specification
      t.boolean  :conform_opportunity
      t.boolean  :accuracy_construct
      t.boolean  :accuracy_topic
      t.boolean  :accuracy_component
      t.boolean  :fit_difficulty
      t.boolean  :fit_important
      t.boolean  :fit_fairness
      t.integer  :programme_id
      t.timestamps
    end
    
    create_table :examsubquestions do |t|
      t.integer  :examquestion_id
      t.integer  :parent_id
      t.string   :sequence
      t.string   :question
      t.string   :classification
      t.integer  :marks
      t.text     :answer
      t.timestamps
    end

    create_table :examanswers do |t|
      t.integer  :examquestion_id
      t.string   :item
      t.string   :answer_desc
      t.timestamps
    end
    
    create_table :exammcqanswers do |t|
      t.integer  :examquestion_id
      t.string   :sequence
      t.string   :answer
      t.timestamps
    end
    
    create_table :answerchoices do |t|
      t.integer  :examquestion_id
      t.string   :item
      t.string   :description
      t.timestamps
    end
    
    create_table :booleananswers do |t|
      t.integer  :examquestion_id
      t.string   :item
      t.boolean  :answer
      t.timestamps
    end

    create_table :booleanchoices do |t|
      t.integer  :examquestion_id
      t.string   :item
      t.string   :description
      t.timestamps
    end
    
    create_table :shortessays do |t|
      t.string   :item
      t.string   :subquestion
      t.decimal  :submark
      t.text     :subanswer
      t.integer  :examquestion_id
      t.string   :keyword
      t.timestamps
    end
    
    create_table :exammakers do |t|
      t.string   :name
      t.text     :description
      t.integer  :creator_id
      t.timestamps
    end
    
    create_table :exammakers_examquestions, :id => false do |t|
      t.integer  :exammaker_id
      t.integer  :examquestion_id
      t.timestamps
    end

    create_table :examsearches do |t|
      t.integer  :programme_id
      t.integer  :subject_id
      t.string   :examtype
      t.integer  :created_by
      t.integer  :klass_id
      t.date     :examdate
      t.timestamps
    end    
  end
  
  def self.down
  end
end