class CreateStaffTrainings < ActiveRecord::Migration
  def self.up   
    create_table :ptbudgets do |t|
      t.decimal  :budget
      t.date     :fiscalstart
      t.timestamps
    end

    create_table :ptcourses do |t|
      t.string   :name
      t.integer  :course_type
      t.integer  :provider_id
      t.decimal  :duration
      t.integer  :duration_type
      t.string   :proponent
      t.decimal  :cost
      t.text     :description
      t.boolean  :approved
      t.timestamps
    end
                 
    create_table :ptdos do |t|
      t.integer  :ptcourse_id
      t.integer  :ptschedule_id
      t.integer  :staff_id
      t.string   :justification
      t.string   :unit_review
      t.boolean  :unit_approve
      t.string   :dept_review
      t.boolean  :dept_approve
      t.integer  :replacement_id
      t.boolean  :final_approve
      t.text     :trainee_report
      t.timestamps
    end

    create_table :ptschedules do |t|
      t.integer  :ptcourse_id
      t.date     :start
      t.string   :location
      t.integer  :min_participants
      t.integer  :max_participants
      t.decimal  :final_price
      t.boolean  :budget_ok
      t.timestamps
    end
    
    create_table :staffcourses do |t|
      t.string   :name
      t.integer  :coursetype
      t.string   :provider
      t.string   :location
      t.decimal  :duration,      :precision => 4, :scale => 1, :default => 0.0
      t.integer  :duration_type
      t.string   :proponent
      t.decimal  :cost,          :precision => 8, :scale => 2, :default => 2.0
      t.date     :course_date
      t.text     :description
      t.timestamps
    end
    
    create_table :trainingrequests do |t|
      t.integer  :staffcourse_id
      t.integer  :staff_id
      t.integer  :appraisal_id
      t.string   :reason
      t.boolean  :submit
      t.date     :submitdate
      t.boolean  :approved
      t.integer  :approvedby_id
      t.date     :approveddate
      t.timestamps
    end
    
    create_table :trainneeds do |t|
      t.string   :name
      t.string   :reason
      t.integer  :confirmedby_id
      t.integer  :evaluation_id
      t.timestamps
    end
  end
  
  def self.down
  end
end