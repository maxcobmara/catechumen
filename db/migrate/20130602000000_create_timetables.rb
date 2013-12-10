class CreateTimetables < ActiveRecord::Migration
  def self.up   
    create_table :timetable_periods do |t|
      t.integer  :timetable_id
      t.integer  :sequence
      t.integer  :day_name
      t.time     :start_at
      t.time     :end_at
      t.boolean  :is_break
      t.timestamps
    end

    create_table :timetables do |t|
      t.string   :code
      t.string   :name
      t.string   :description
      t.integer  :created_by
      t.timestamps
    end
    
    create_table :weeklytimetable_details do |t|
      t.integer  :subject
      t.integer  :topic
      t.integer  :time_slot
      t.integer  :lecturer_id
      t.integer  :weeklytimetable_id
      t.integer  :day2
      t.boolean  :is_friday
      t.integer  :time_slot2
      t.integer  :location
      t.integer  :lecture_method
      t.timestamps
    end

    create_table :weeklytimetables do |t|
      t.integer  :programme_id
      t.integer  :intake_id
      t.integer  :group_id
      t.date     :startdate
      t.date     :enddate
      t.integer  :semester
      t.integer  :prepared_by
      t.integer  :endorsed_by
      t.integer  :format1
      t.integer  :format2
      t.integer  :week
      t.boolean  :is_submitted
      t.date     :submitted_on
      t.boolean  :hod_approved
      t.date     :hod_approved_on
      t.boolean  :hod_rejected
      t.date     :hod_rejected_on
      t.string   :reason
      t.timestamps
    end

    create_table :weeklytimetablesearches do |t|
      t.integer  :programme_id
      t.date     :startdate
      t.date     :enddate
      t.integer  :preparedby
      t.integer  :intake_id
      t.integer  :intake
      t.timestamps
    end
    
    create_table :personalizetimetablesearches do |t|
      t.integer  :lecturer
      t.integer  :programme_id
      t.timestamps
    end
  end
  
  def self.down
  end
end

 