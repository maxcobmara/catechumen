class CreateCourseEvaluations < ActiveRecord::Migration
  def self.upv
    create_table :courseevaluations do |t|
      t.integer  :student_id
      t.integer  :programme_id
      t.integer  :subject_id
      t.timestamps
    end
       
    create_table :average_courses do |t|
      t.integer  :lecturer_id
      t.integer  :programme_id
      t.string   :dissactifaction
      t.string   :recommend_for_improvement
      t.string   :summary_evaluation
      t.string   :evaluate_category
      t.string   :support_justify
      t.integer  :principal_id
      t.date     :principal_date
      t.integer  :subject_id
      t.integer  :delivery_quality
      t.integer  :lecturer_knowledge
      t.timestamps
    end
    
    create_table :evaluate_courses do |t|
      t.integer  :course_id
      t.integer  :subject_id
      t.integer  :staff_id
      t.integer  :student_id
      t.date     :evaluate_date
      t.string   :comment
      t.integer  :ev_obj
      t.integer  :ev_knowledge
      t.integer  :ev_deliver
      t.integer  :ev_content
      t.integer  :ev_tool
      t.integer  :ev_topic
      t.integer  :ev_work
      t.integer  :ev_note
      t.string   :invite_lec
      t.integer  :average_course_id
      t.timestamps
    end

    create_table :evaluatecoursesearches do |t|
      t.integer  :programme_id
      t.integer  :subject_id
      t.date     :evaldate
      t.integer  :lecturer_id
      t.timestamps
    end
  end
  
  def self.down
  end
end