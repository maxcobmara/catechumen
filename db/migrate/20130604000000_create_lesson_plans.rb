class CreateLessonPlans < ActiveRecord::Migration
  def self.up   
    create_table :lesson_plans do |t|
      t.integer  :lecturer
      t.integer  :intake_id
      t.integer  :student_qty
      t.integer  :semester
      t.integer  :topic
      t.string   :lecture_title
      t.date     :lecture_date
      t.time     :start_time
      t.time     :end_time
      t.text     :reference
      t.boolean  :is_submitted
      t.date     :submitted_on
      t.boolean  :hod_approved
      t.date     :hod_approved_on
      t.boolean  :hod_rejected
      t.date     :hod_rejected_on
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_ot
      t.string   :prerequisites
      t.integer  :year
      t.text     :reason
      t.integer  :prepared_by
      t.integer  :endorsed_by
      t.boolean  :condition_isgood
      t.boolean  :condition_isnotgood
      t.string   :condition_desc
      t.text     :training_aids
      t.text     :summary
      t.integer  :total_absent
      t.boolean  :report_submit
      t.date     :report_submit_on
      t.boolean  :report_endorsed
      t.date     :report_endorsed_on
      t.text     :report_summary
      t.integer  :schedule
      t.timestamps
    end
    
    create_table :lesson_plan_trainingnotes do |t|
      t.integer  :lesson_plan_id
      t.integer  :trainingnote_id
      t.timestamps
    end

    create_table :lessonplan_methodologies do |t|
      t.text     :content
      t.text     :lecturer_activity
      t.text     :student_activity
      t.text     :training_aids
      t.text     :evaluation
      t.integer  :lesson_plan_id
      t.time     :start_meth
      t.time     :end_meth
      t.timestamps
    end

    create_table :lessonplansearches do |t|
      t.integer  :lecturer
      t.integer  :intake_id
      t.integer  :programme_id
      t.integer  :intake
      t.timestamps
    end
    
    create_table :topicdetails do |t|
      t.string   :topic_name
      t.integer  :topic_code
      t.time     :duration
      t.float    :version_no
      t.text     :objctives
      t.text     :contents
      t.time     :theory
      t.time     :tutorial
      t.time     :practical
      t.integer  :prepared_by
      t.timestamps
    end

    create_table :trainingnotes do |t|
      t.integer  :timetable_id
      t.string   :title
      t.string   :reference
      t.string   :version
      t.string   :staff_id
      t.date     :release
      t.string   :document_file_name
      t.string   :document_content_type
      t.integer  :document_file_size
      t.datetime :document_updated_at
      t.integer  :topicdetail_id
      t.timestamps
    end
    
    create_table :trainingreports do |t|
      t.integer  :classtype
      t.integer  :timetable_id
      t.boolean  :location_state
      t.text     :ls_comment
      t.text     :staff_comment
      t.integer  :staff_id
      t.boolean  :submit
      t.text     :tpa_comment
      t.integer  :tpa_id
      t.timestamps
    end
  end
  
  def self.down
  end
end

 