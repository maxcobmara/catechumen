class CreateStudentCounsellings < ActiveRecord::Migration
  def self.up
    create_table :student_counseling_sessions do |t|
      t.integer  :student_id
      t.integer  :case_id
      t.datetime :requested_at
      t.text     :alt_dates
      t.string   :c_type
      t.string   :c_scope
      t.integer  :duration
      t.boolean  :is_confirmed
      t.datetime :confirmed_at
      t.text     :issue_desc
      t.text     :notes
      t.integer  :file_id
      t.text     :suggestions
      t.integer  :staff_id
      t.integer  :created_by
      t.string   :created_by_type
      t.integer  :confirmed_by
      t.string   :confirmed_by_type
      t.text     :remark
      t.timestamps
    end

    create_table :student_discipline_cases do |t|
      t.integer  :reported_by
      t.integer  :student_id
      t.integer  :infraction_id
      t.text     :description
      t.date     :reported_on
      t.integer  :assigned_to
      t.date     :assigned_on
      t.string   :status
      t.integer  :file_id
      t.text     :investigation_notes
      t.string   :action_type
      t.text     :other_info
      t.date     :case_created_on
      t.text     :action
      t.integer  :location_id
      t.integer  :assigned2_to
      t.date     :assigned2_on
      t.boolean  :is_innocent
      t.date     :closed_at_college_on
      t.date     :sent_to_board_on
      t.date     :board_meeting_on
      t.date     :board_decision_on
      t.text     :board_decision
      t.date     :appeal_on
      t.text     :appeal_decision
      t.date     :appeal_decision_on
      t.text     :counselor_feedback
      t.timestamps
    end
       
    create_table :counsellings do |t|
      t.integer  :student_id
      t.integer  :cofile_id
      t.timestamps
    end
    
    create_table :scsessions do |t|
      t.integer  :counselling_id
      t.datetime :scsessiondt
      t.time     :scsessiondtduration
      t.integer  :scsappointnum
      t.string   :scsessiontype
      t.string   :issue
      t.text     :suggestion
      t.text     :remarks
      t.timestamps
    end
    
    create_table :studentcounselingsearches do |t|
      t.string   :matrixno
      t.integer  :case_id
      t.timestamps
    end

    create_table :studentdisciplinesearches do |t|
      t.string   :name
      t.integer  :programme
      t.date     :intake
      t.string   :matrixno
      t.timestamps
    end
  end
  
  def self.down
  end
end

 