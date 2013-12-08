class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string   :icno
      t.string   :name
      t.string   :matrixno
      t.string   :sstatus
      t.string   :stelno
      t.string   :ssponsor
      t.integer  :gender
      t.date     :sbirthdt
      t.integer  :mrtlstatuscd
      t.string   :semail
      t.date     :regdate
      t.integer  :course_id
      t.integer  :specilisation
      t.integer  :group_id
      t.string   :physical
      t.string   :allergy
      t.string   :disease
      t.string   :bloodtype
      t.string   :medication
      t.text     :remarks
      t.string   :offer_letter_serial
      t.string   :race
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at
      t.text     :address
      t.text     :address_posbasik
      t.date     :end_training
      t.date     :intake
      t.string   :specialisation
      t.integer  :intake_id
      t.timestamps
    end
    
    create_table :spmresults do |t|
      t.integer  :student_id
      t.string   :spm_subject
      t.integer  :spmsubject_id
      t.string   :grade
      t.timestamps
    end
    
    create_table :student_attendances do |t|
      t.integer  :student_id
      t.boolean  :attend
      t.integer  :weeklytimetable_details_id
      t.string   :reason
      t.string   :action
      t.string   :status
      t.string   :remark
      t.timestamps
    end
    
    create_table :studentattendances do |t|
      t.integer  :timetable_id
      t.integer  :student_id
      t.boolean  :attend
      t.timestamps
    end
       
    create_table :leaveforstudents do |t|
      t.integer  :student_id
      t.string   :leavetype
      t.date     :requestdate
      t.string   :reason
      t.string   :address
      t.string   :telno
      t.date     :leave_startdate
      t.date     :leave_enddate
      t.boolean  :studentsubmit
      t.boolean  :approved
      t.integer  :staff_id
      t.date     :approvedate
      t.text     :notes
      t.timestamps
    end
    
    create_table :studentsearches do |t|
      t.string   :icno
      t.string   :name
      t.string   :matrixno
      t.string   :ssponsor
      t.integer  :mrtlstatuscd
      t.integer  :course_id
      t.string   :physical
      t.date     :end_training
      t.date     :intake
      t.integer  :gender
      t.string   :race
      t.string   :bloodtype
      t.string   :sstatus
      t.date     :end_training2
      t.timestamps
    end
    
    create_table :studentattendancesearches do |t|
      t.integer  :schedule_id
      t.date     :intake_id
      t.string   :student_id
      t.timestamps
    end
  end
  
  def self.down
  end
end

 